//
//  LanguageLabel.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 12/6/24.
//

import UIKit

final class LanguageLabel: BaseView {
    private let containLabels: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 4
        return view
    }()
    private let languageLabel: UILabel = {
        let view = UILabel()
        view.font = .title2
        view.textAlignment = .center
        view.textColor = .gray1
        return view
    }()
    private let levelLabel: UILabel = {
        let view = UILabel()
        view.font = .body
        view.textAlignment = .center
        view.textColor = .gray1
        return view
    }()
    
    private var languageState: LangState
    
    init(languageState: LangState) {
        self.languageState = languageState
        super.init()
    }
    
    override func setHierarchy() { 
        addSubview(containLabels)
        
        [languageLabel, levelLabel].forEach {
            containLabels.addArrangedSubview($0)
        }
    }
    
    override func setConstraints() {
        containLabels.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupLanguages(language: Country) {
        languageLabel.text = language.toLang
        
        switch languageState {
        case .mine:
            levelLabel.text = "Lv.\(Int.random(in: 3...5))"
        case .other:
            levelLabel.text = "Lv.\(Int.random(in: 0...2))"
        }
    }
}
