//
//  SlideTransition.swift
//  BuddyBuddy
//
//  Created by 아라 on 12/9/24.
//

import UIKit

final class SlideTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting = false
    
    func transitionDuration(using transitionContext:
                            (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from)
        else { return }
        
        let containerView = transitionContext.containerView
        
        let width = toViewController.view.bounds.width
        let height = toViewController.view.bounds.height
        
        if isPresenting {
            containerView.addSubview(toViewController.view)
            toViewController.view.frame = CGRect(
                x: -width,
                y: 0,
                width: width,
                height: height
            )
        }
        
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        
        UIView.animate(
            withDuration: duration,
            animations: { [weak self] in
                guard let self else { return }
                
                if isPresenting {
                    toViewController.view.transform = CGAffineTransform(
                        translationX: width,
                        y: 0
                    )
                } else {
                    fromViewController.view.transform = .identity
                }
            }) { _ in
                transitionContext.completeTransition(!isCancelled)
            }
    }
}
