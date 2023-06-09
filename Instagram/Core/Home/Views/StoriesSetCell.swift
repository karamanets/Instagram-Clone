//
//  StoriesSetCell.swift
//  Instagram
//
//  Created by Alex Karamanets on 19.04.2023.
//

import UIKit
import SnapKit

final class StoriesSetCell: UITableViewCell {
    
    //MARK: Public method
    public func configure(with info: [HomeStoryModel]) {
        self.dataService = info
        collectionView.reloadData()
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
        collectionView.showsHorizontalScrollIndicator = false
        ///Register Cell
        collectionView.register(StoriesCell.self, forCellWithReuseIdentifier: String(describing: StoriesCell.self))
    
        return collectionView
    }()
    
    ///Data Cervice
    private var dataService: [HomeStoryModel] = []
}

//MARK: - Private methods
private extension StoriesSetCell {
    
    func initialize() {
        ///View
        contentView.backgroundColor = UIColor.theme.background
        /// CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        
        /// Constraints
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: CollectionView DataSource
extension StoriesSetCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataService.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                        String(describing: StoriesCell.self), for: indexPath) as! StoriesCell
        cell.configure(with: dataService[indexPath.item])
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

//MARK: CollectionView Delegate
extension StoriesSetCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("[⚠️] Selected story: \(indexPath.item)")
    }
}

