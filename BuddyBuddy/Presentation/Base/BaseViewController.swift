//
//  BaseViewController.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/6/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        bind()
        setHierarchy()
        setConstraints()
        setView()
    }
    
    func setView() {
        view.backgroundColor = .white
    }
    
    func bind() { }
    
    func setHierarchy() { }
    
    func setConstraints() { }
    
}
