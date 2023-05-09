//
//  StoriesSetCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 19.04.2023.
//

import UIKit
import SnapKit

final class StoriesSetCell: UITableViewCell {
    
    //private var collectionView2 = UICollectionView()
    
    //MARK: Public method
    func configure(with info: StoriesCellInfo) {
        self.items = info
        collectionView.reloadData()
        //print(info)
    }
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(StoriesItemCell.self, forCellWithReuseIdentifier: String(describing: StoriesItemCell.self))
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    /// typealias name (array)
    private var items: StoriesCellInfo = []
}

//MARK: - Private methods
private extension StoriesSetCell {
    
    func initialize() {
        /// CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        
        /// Constraints
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(contentView.bounds.height * 2.6)
        }
    }
}

//MARK: CollectionView DataSource
extension StoriesSetCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        String(describing: StoriesItemCell.self), for: indexPath) as! StoriesItemCell
        cell.configure(with: items[indexPath.item])
        return cell
    }
}

//MARK: CollectionView Delegate FlowLayout
extension StoriesSetCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width / 5
        
        let height = collectionView.bounds.height - 16
        
        return CGSize(width: width, height: height)
    }
    
    
}


