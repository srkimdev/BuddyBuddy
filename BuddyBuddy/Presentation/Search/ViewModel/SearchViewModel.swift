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
    private let playgroundUseCase: PlaygroundUseCaseInterface
    
    init(
        coordinator: SearchCoordinator,
        playgroundUseCase: PlaygroundUseCaseInterface
    ) {
        self.coordinator = coordinator
        self.playgroundUseCase = playgroundUseCase
    }
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let inputText: Observable<String>
        let inputSegIndex: Observable<Int>
        let selectedCell: Observable<SearchResult>
        let searchCancelBtnTapped: Observable<Void>
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
        var totalInfo: [SearchResult] = []
        
        input.viewWillAppear
            .withUnretained(self)
            .flatMap { (viewModel, _) in
                return viewModel.playgroundUseCase.fetchPlaygroundInfo()
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    searchResult = value
                    totalInfo = value
                    owner.updateSearchData(
                        state: .channel,
                        searchResult: searchResult,
                        searchData: searchData,
                        searchedResult: searchedResult,
                        emptyResult: emptyResult
                    )
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        input.searchCancelBtnTapped
            .bind(with: self) { owner, _ in
                owner.updateSearchData(
                    state: .channel,
                    searchResult: totalInfo,
                    searchData: searchData,
                    searchedResult: searchedResult,
                    emptyResult: emptyResult
                )
                selectedSegIndex.onNext(0)
            }
            .disposed(by: disposeBag)
        
        input.inputText
            .withUnretained(self)
            .flatMap { (viewModel, inputText) in
                return viewModel.playgroundUseCase.searchInPlayground(text: inputText)
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let value):
                    searchResult = value
                    owner.updateSearchData(
                        state: .channel,
                        searchResult: searchResult,
                        searchData: searchData,
                        searchedResult: searchedResult,
                        emptyResult: emptyResult
                    )
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        input.inputSegIndex
            .bind(with: self) { owner, segIndex in
                let state: SearchState = (segIndex == 0) ? .channel : .user
                owner.updateSearchData(
                    state: state,
                    searchResult: searchResult,
                    searchData: searchData, 
                    searchedResult: searchedResult,
                    emptyResult: emptyResult
                )
            }
            .disposed(by: disposeBag)
        
        input.selectedCell
            .bind(with: self) { owner, selected in
                switch selected.state {
                case .channel:
                    print("Channel", selected)
                case .user:
                    owner.coordinator.toProfile(userID: selected.id)
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
    
    private func updateSearchData(
        state: SearchState,
        searchResult: [SearchResult],
        searchData: PublishSubject<SearchImageType>,
        searchedResult: PublishSubject<[SearchResult]>,
        emptyResult: PublishSubject<Bool>
    ) {
        let filteredResults = searchResult.filter { $0.state == state }
        let imageType: SearchImageType = state == .channel ? .channel : .country(emoji: .kr)
        
        searchData.onNext(imageType)
        searchedResult.onNext(filteredResults)
        emptyResult.onNext(filteredResults.isEmpty)
    }
}
