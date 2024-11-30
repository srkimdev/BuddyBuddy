//
//  DefaultDMRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/19/24.
//

import Foundation

import RxSwift

final class DefaultDMRepository: DMRepositoryInterface {
    private let networkService: NetworkProtocol
    private let realmRepository: RealmRepository<DMHistoryTable>
    
    init(
        networkService: NetworkProtocol,
        realmRepository: RealmRepository<DMHistoryTable>
    ) {
        self.networkService = networkService
        self.realmRepository = realmRepository
    }
    
    func fetchDMList(playgroundID: String) -> RxSwift.Single<Result<[DMList], Error>> {
        return networkService.callRequest(
            router: DMRouter.dmList(playgroundID: playgroundID),
            responseType: [DMListDTO].self
        )
        .map { result in
            switch result {
            case .success(let dto):
                return .success(dto.map { $0.toDomain() })
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func fetchDMHistoryString(
        playgroundID: String,
        roomID: String
    ) -> RxSwift.Single<Result<[DMHistoryString], Error>> {
        let chatHistory = realmRepository.readAllItem().filter {
            $0.roomID == roomID
        }
        return networkService.callRequest(
            router: DMRouter.dmHistory(
                playgroundID: playgroundID,
                roomID: roomID,
                cursorDate: chatHistory.last?.createdAt ?? ""
            ),
            responseType: [DMHistoryDTO].self
        )
        .map { result in
            switch result {
            case .success(let dto):
                let dmHistoryTable = dto.map { $0.toTable() }
                dmHistoryTable.forEach { self.realmRepository.updateItem($0) }
                    
                return .success(dto.map { $0.toDomain() })
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func fetchDMNoRead(
        playgroundID: String,
        roomID: String,
        after: String
    ) -> RxSwift.Single<Result<DMUnRead, Error>> {
        return networkService.callRequest(
            router: DMRouter.dmUnRead(
                playgroundID: playgroundID,
                roomID: roomID,
                after: after
            ),
            responseType: DMUnReadDTO.self)
        .map { result in
            switch result {
            case .success(let dto):
                return .success(dto.toDomain())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func sendDM(
        playgroundID: String,
        roomID: String,
        message: String,
        files: [Data]
    ) -> Single<Result<DMHistoryString, Error>> {
        return networkService.callMultiPart(
            router: DMRouter.dmSend(
                playgroundID: playgroundID,
                roomID: roomID
            ),
            responseType: DMHistoryDTO.self,
            content: message,
            files: files
        )
        .map { result in
            switch result {
            case .success(let dto):
                self.realmRepository.updateItem(dto.toTable())
                return .success(dto.toDomain())
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    func convertToDMHistoryArray(roomID: String) -> Single<Result<[DMHistory], Error>> {
        let dmHistoryTables = realmRepository.readAllItem().filter {
            $0.roomID == roomID
        }
        
        let dmHistoryTasks = dmHistoryTables.map { dmHistoryTable in
            Single.zip(dmHistoryTable.files.map { filePath in
                self.networkService.downloadImage(router: DMRouter.dmImage(path: filePath))
            })
            .map { results -> [Data] in
                let fileDataArray = results.compactMap { result in
                    switch result {
                    case .success(let value):
                        return value
                    case .failure(let error):
                        print(error)
                        return nil
                    }
                }
                return fileDataArray
            }
            .map { fileDataResult -> DMHistory in
                let dmHistory = DMHistory(
                    dmID: dmHistoryTable.dmID,
                    roomID: dmHistoryTable.roomID,
                    content: dmHistoryTable.content,
                    createdAt: dmHistoryTable.createdAt,
                    files: fileDataResult,
                    user: UserInfo(
                        userID: dmHistoryTable.user?.userID ?? "",
                        email: dmHistoryTable.user?.email ?? "",
                        nickname: dmHistoryTable.user?.nickname ?? "",
                        profileImage: dmHistoryTable.user?.profileImage
                    )
                )
                return dmHistory
            }
        }
        return Single.zip(dmHistoryTasks)
            .map { results in
                return .success(results)
            }
            .catch { error in
                return .just(.failure(error))
            }
    }
}
