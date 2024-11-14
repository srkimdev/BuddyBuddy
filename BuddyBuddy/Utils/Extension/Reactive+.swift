//
//  Reactive+.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/12/24.
//

import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewWillAppear: RxSwift.Observable<Void> {
        return methodInvoked(#selector(base.viewWillAppear(_:)))
            .map { _ in () }
    }

    var viewDidAppear: RxSwift.Observable<Void> {
        return methodInvoked(#selector(base.viewDidAppear(_:)))
            .map { _ in () }
    }

    var viewWillDisappear: RxSwift.Observable<Void> {
        return methodInvoked(#selector(base.viewWillDisappear(_:)))
            .map { _ in () }
    }

    var viewDidDisappear: RxSwift.Observable<Void> {
        return methodInvoked(#selector(base.viewDidDisappear(_:)))
            .map { _ in () }
    }
}
