//
//  PlaygroundRepositoryInterface.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/19/24.
//

import Foundation

import RxCocoa
import RxSwift

protocol PlaygroundRepositoryInterface: AnyObject {
    func searchPlaygournd(text: String) -> Single<Result<PlaygroundSearch, Error>>
}
