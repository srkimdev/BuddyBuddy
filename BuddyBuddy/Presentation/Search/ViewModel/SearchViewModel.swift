//
//  SearchViewModel.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import Foundation

import RxCocoa
import RxSwift

final class SearchViewModel: ViewModelType {
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let coordinator: SearchCoordinator
    private let useCase: PlaygroundUseCaseInterface
    
    init(
        coordinator: SearchCoordinator,
        useCase: PlaygroundUseCaseInterface
    ) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let inputText: Observable<String>
        let inputSegIndex: Observable<Int>
    }
    
    struct Output {
        let selectedSegIndex: Driver<Int>
        let searchData: Driver<SearchImageType>
        let searchedResult: Driver<[SearchResult]>
        let emptyResult: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let selectedSegIndex = PublishSubject<Int>()
        let searchData = PublishSubject<SearchImageType>()
        let searchedResult = PublishSubject<[SearchResult]>()
        let emptyResult = PublishSubject<Bool>()
        
        var searchResult: [SearchResult] = []
        
        input.viewWillAppear
            .bind { _ in
                // TODO: 전체 채널 목록 + 유저 목록
            }
            .disposed(by: disposeBag)
        
        input.inputText
            .bind(with: self) { owner, text in
                owner.useCase.searchInPlayground(text: text)
                    .subscribe { result in
                        switch result {
                        case .success(let value):
                            selectedSegIndex.onNext(SearchState.channel.rawValue)
                            searchResult = owner.mappingSearchResult(
                                channel: value.channels,
                                member: value.playgroundMembers
                            )
                            searchData.onNext(SearchImageType.channel)
                            searchedResult.onNext(searchResult.filter { $0.state == .channel })
                            emptyResult.onNext(searchResult.filter { $0.state == .channel }.isEmpty)
                        case .failure(let error):
                            print(error)
                        }
                    }
                    .disposed(by: owner.disposeBag)
            }
            .disposed(by: disposeBag)
        
        input.inputSegIndex
            .bind { segIndex in
                if segIndex == 1 {
                    // TODO: 국가 변환
                    searchData.onNext(SearchImageType.country(emoji: .kr))
                    searchedResult.onNext(searchResult.filter { $0.state == .user })
                    emptyResult.onNext(searchResult.filter { $0.state == .user }.isEmpty)
                } else if segIndex == 0 {
                    searchData.onNext(SearchImageType.channel)
                    searchedResult.onNext(searchResult.filter { $0.state == .channel })
                    emptyResult.onNext(searchResult.filter { $0.state == .channel }.isEmpty)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            selectedSegIndex: selectedSegIndex.asDriver(onErrorJustReturn: 0),
            searchData: searchData.asDriver(onErrorJustReturn: .channel),
            searchedResult: searchedResult.asDriver(onErrorJustReturn: []),
            emptyResult: emptyResult.asDriver(onErrorJustReturn: false)
        )
    }
    
    private func mappingSearchResult(
        channel: [PlaygroundChannel],
        member: [PlaygroundMember]
    ) -> [SearchResult] {
        let channelResult: [SearchResult] = channel.map {
            .init(
                state: .channel,
                id: $0.channelID,
                name: $0.channelName
            )
        }
        let memberResult: [SearchResult] = member.map {
            .init(
                state: .user,
                id: $0.userID,
                name: $0.nickname
            )
        }
        return channelResult + memberResult
    }
}
