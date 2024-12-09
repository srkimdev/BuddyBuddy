//
//  SlidePresentationController.swift
//  BuddyBuddy
//
//  Created by 아라 on 12/5/24.
//

import UIKit

final class SlidePresentationController: UIPresentationController {
    private let dimmingView = UIView()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard var frame = containerView?.frame else {
            return .zero
        }
        
        frame.origin = CGPoint(x: 0, y: 0)
        frame.size.width = frame.size.width
        frame.size.height = frame.size.height
        
        return frame
    }
    
    var transitionCoordinator: UIViewControllerTransitionCoordinator?
    
    override init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        super.init(
            presentedViewController: presentedViewController,
            presenting: presentingViewController
        )
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionWillBegin() {
        setupDimmingViewLayout()
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.5
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.5
        })
    }
    
    func setupDimmingViewLayout() {
        dimmingView.alpha = 0.0
        
        containerView?.insertSubview(dimmingView, at: 0)
        
        dimmingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { [weak self] _ in
                guard let self else { return }
                dimmingView.alpha = 0.0
                presentingViewController.view.transform = CGAffineTransform.identity
                containerView?.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        presentingViewController.endAppearanceTransition()
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
}
