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

extension Reactive where Base: BuddyAlert {
    var tap: Observable<Void> {
        let tapGesture = UITapGestureRecognizer()
        
        base.addGestureRecognizer(tapGesture)
        base.isUserInteractionEnabled = true
        
        return tapGesture.rx.event
            .filter { [weak base] gesture in
                guard let base else { return false }
                let tapLocation = gesture.location(in: base)
                return !base.containerView.frame.contains(tapLocation)
            }
            .map { _ in () }
            .asObservable()
    }
}
