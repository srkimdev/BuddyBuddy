//
//  SearchItemTableViewCell.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/11/24.
//

import UIKit

import SnapKit

final class SearchItemTableViewCell: BaseTableViewCell {
    private let searchedImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.tintColor = .black
        return view
    }()
    
    private let searchedTerms: UILabel = {
        let view = UILabel()
        view.font = .bodyBold
        view.textColor = .black
        return view
    }()
    
    override func setHierarchy() {
        [searchedImg, searchedTerms]
            .forEach { contentView.addSubview($0) }
    }
    
    override func setConstraints() {
        searchedImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
            make.leading.equalToSuperview().inset(16)
            
        }
        searchedTerms.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(searchedImg.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
        }
    }
    
    func setupUI(text: String) {
        searchedTerms.text = text
    }
    
    func setupImageUI(imgType: SearchImageType) {
        searchedImg.image = UIImage(systemName: imgType.toImgTitle)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        searchedTerms.text = nil
        searchedImg.image = nil
    }
}
