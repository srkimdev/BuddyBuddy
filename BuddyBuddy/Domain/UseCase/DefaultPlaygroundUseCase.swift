//
//  DefaultPlaygroundUseCase.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/19/24.
//

import Foundation

import RxCocoa
import RxSwift

final class DefaultPlaygroundUseCase: PlaygroundUseCaseInterface {
    @Dependency(PlaygroundRepositoryInterface.self)
    private var repository: PlaygroundRepositoryInterface
    @Dependency(UserRepositoryInterface.self)
    private var userRepository: UserRepositoryInterface
    
    func fetchPlaygroundInfoWithImage() -> Single<Result<[SearchResultWithImage], Error>> {
        return repository.fetchPlaygroundInfo()
            .flatMap { [weak self] result in
                guard let self else { return Single.just(.success([]))}
                
                switch result {
                case .success(let info):
                    let images = info.map { result in
                        self.userRepository.getUserProfileImage(imagePath: result.file)
                    }
                    return Single.zip(images) { [weak self] images in
                        guard let self else { return .success([]) }
                        let profileImages = self.changeDataArray(imageResults: images)
                        let searchResults = self.changedSearchResult(
                            searchInfo: info, 
                            images: profileImages
                        )
                        return .success(searchResults)
                        
                    }
                case .failure(let error):
                    return .just(.failure(error))
                }
            }
    }
    
    func searchInPlaygroundWithImage(text: String)
    -> Single<Result<[SearchResultWithImage], Error>> {
        return repository.searchPlaygournd(text: text)
            .flatMap { [weak self] result in
                guard let self else { return .just(.success([])) }
                
                switch result {
                case .success(let info):
                    let images = info.map { result in
                        self.userRepository.getUserProfileImage(imagePath: result.file)
                    }
                    return Single.zip(images) { [weak self] images in
                        guard let self else { return .success([]) }
                        let profileImages = self.changeDataArray(imageResults: images)
                        
                        let searchResults = self.changedSearchResult(
                            searchInfo: info,
                            images: profileImages
                        )
                        return .success(searchResults)
                        
                    }
                case .failure(let error):
                    return .just(.failure(error))
                }
            }
    }
    
    private func changeDataArray(imageResults: [Result<Data?, Error>]) -> [Data?] {
        imageResults.map { result in
            switch result {
            case .success(let data):
                return data
            case .failure:
                return nil
            }
        }
    }
    private func changedSearchResult(
        searchInfo: [SearchResult],
        images: [Data?]
    ) -> [SearchResultWithImage] {
        let infos = zip(searchInfo, images).map { info, imageData in
            SearchResultWithImage(
                state: info.state,
                id: info.id,
                name: info.name,
                image: imageData
            )
        }
        
        return infos
    }
    
    func fetchPlaygroundList() -> Single<Result<PlaygroundList, any Error>> {
        return repository.fetchPlaygroundList()
    }
    
    func fetchCurrentPlayground() -> Single<Result<Playground, any Error>> {
        return repository.fetchCurrentPlayground()
    }
}
