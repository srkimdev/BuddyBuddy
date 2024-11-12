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
    
    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let inputSegIndex: Observable<Int>
    }
    
    struct Output {
        let selectedSegIndex: Driver<Int>
        let searchState: Driver<SearchState>
        let recentSearchList: Driver<[String]>
        let searchData: Driver<SearchImageType>
    }
    
    func transform(input: Input) -> Output {
        let selectedSegIndex = PublishSubject<Int>()
        let searchState = PublishSubject<SearchState>()
        let recentSearchList = PublishSubject<[String]>()
        let searchData = PublishSubject<SearchImageType>()
        
        let sampleData = ["하이루2", "이건 사용자", "함지수", "선아라", "김성률"]
        let sampleData2 = ["감자도리", "함지수", "선아라", "김성률"]
        
        input.viewWillAppear
            .bind { _ in
                searchState.onNext(.searchResult)
                selectedSegIndex.onNext(0)
                searchData.onNext(SearchImageType.channel)
                recentSearchList.onNext(sampleData2)
            }
            .disposed(by: disposeBag)
        
        input.inputSegIndex
            .bind { segIndex in
                if segIndex == 1 {
                    searchData.onNext(SearchImageType.person)
                    recentSearchList.onNext(sampleData)
                } else if segIndex == 0 {
                    searchData.onNext(SearchImageType.channel)
                    recentSearchList.onNext(sampleData2)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            selectedSegIndex: selectedSegIndex.asDriver(onErrorJustReturn: 0),
            searchState: searchState.asDriver(onErrorJustReturn: .empty),
            recentSearchList: recentSearchList.asDriver(onErrorJustReturn: []), 
            searchData: searchData.asDriver(onErrorJustReturn: .channel)
        )
    }
}
