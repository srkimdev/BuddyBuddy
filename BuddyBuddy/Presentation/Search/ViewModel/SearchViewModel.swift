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
    }
    
    struct Output {
        let searchState: Driver<SearchState>
        let recentSearchList: Driver<[String]>
    }
    
    func transform(input: Input) -> Output {
        let searchState = PublishSubject<SearchState>()
        let recentSearchList = PublishSubject<[String]>()
        
        input.viewWillAppear
            .bind { _ in
                searchState.onNext(.recentSearch)
                recentSearchList.onNext(["감자도리", "함지수", "선아라", "김성률"])
            }
            .disposed(by: disposeBag)
        
        return Output(
            searchState: searchState.asDriver(onErrorJustReturn: .empty),
            recentSearchList: recentSearchList.asDriver(onErrorJustReturn: [])
        )
    }
    
}
