//
//  ProfileGallertCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 29/05/2023.
//

import UIKit

class ProfileGalleryCell_2: UICollectionViewCell {
    
    //MARK: Public
    func configure(with imageName: String) {
        self.imageView.image = UIImage(named: imageName)
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Constants
    private enum UIConstants {
        static let iconTop: CGFloat = 10
        static let iconTrailing: CGFloat = -10
        static let iconSize: CGFloat = 20
        static let iconCornerRadius: CGFloat = 3
        static let shadowRadiusCell: CGFloat = 1
        static let shadowOpacityCell: Float = 0.2
    }
    
    //MARK: Private property
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = UIConstants.iconCornerRadius
        return view
    }()
    
    private let icon: UIImageView = {
        let icon = UIImage(systemName: "photo.fill.on.rectangle.fill")?
            .withRenderingMode(.alwaysTemplate)
        let view = UIImageView(image: icon)
        view.tintColor = .white
        return view
    }()

}

//MARK: - Private methods
private extension ProfileGalleryCell_2 {
    
    func initialize() {
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = UIConstants.shadowRadiusCell
        contentView.layer.shadowOpacity = UIConstants.shadowOpacityCell
        contentView.layer.shadowOffset = .zero
    
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.top.equalTo(UIConstants.iconTop)
            make.trailing.equalTo(UIConstants.iconTrailing)
            make.size.equalTo(UIConstants.iconSize)
        }
    }
}
