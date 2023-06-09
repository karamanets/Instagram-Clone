//
//  ProfileStoriesCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 23/05/2023.
//

import UIKit
import SnapKit

final class ProfileStoriesCell_2: UICollectionViewCell {
    
    //MARK: Public
    public func configure(with info: ProfileStoryModel_2) {
        imageView.image = UIImage(named: info.imageName)
    }
    
    //MARK: UiConstants
    private enum UiConstants {
        static let imageSize: CGFloat = 80
        static let imageInset: CGFloat = 8
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Property
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = UiConstants.imageSize / 2
        return view
    }()
}

//MARK: - Private Methods
private extension ProfileStoriesCell_2 {
    
    func initialize() {
    
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UiConstants.imageInset)
            make.size.equalTo(UiConstants.imageSize)
        }
    }
}
