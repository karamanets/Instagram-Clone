//
//  FeedViewController.swift
//  Instagram
//
//  Created by Alex Karamanets on 19.04.2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
        
    //MARK: UiConstants
    private enum UiConstants {
        static let barItemHeight:CGFloat = 30
        static let barItemWidth: CGFloat = 34
        static let storyRowHeight: CGFloat = 120
    }
    
    //MARK: Private properties
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.theme.background
        /// Register  cells
        tableView.register(StoriesSetCell.self, forCellReuseIdentifier: String(describing: StoriesSetCell.self))
        tableView.register(PostCell.self, forCellReuseIdentifier: String(describing: PostCell.self))
        return tableView
    }()
    
    /// DataService
    private var dataService: [HomeType] = FakeDataService.shared.homeType
}

//MARK: - Private methods
private extension HomeViewController {
    
    func initialize() {
        /// View
        view.backgroundColor = UIColor.theme.background
        /// Methods
        setUpBarItems()
        
        /// Elements
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: Bar Items
private extension HomeViewController {
    
    func setUpBarItems() {
        /// Make icon left item black
        navigationController?.navigationBar.tintColor = .black
        /// Add Bar Items
        navigationItem.leftBarButtonItems = makeLeftBarButtonItem()
        navigationItem.rightBarButtonItems = makeRightBarButtonItem()
        
        makeBarBottomIcon()
    }
    
    /// Bar bottom image title tag
    func makeBarBottomIcon() {
        let size = CGSize(width: UiConstants.barItemWidth, height: UiConstants.barItemHeight)
        
        let icon = UIImage(systemName: "homekit")
        
        let image = icon?.imageResized(to: size).withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        
        let tabItem = UITabBarItem(title: "", image: image , tag: 0)
        self.tabBarItem = tabItem
    }
    
    /// Bar Button left
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        
        /// Add logo mage
        let logoBarButtonItem = UIBarButtonItem(customView: LogoView())
        /// Add bar button
        let image = UIImage(systemName: "chevron.down")?.withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        let dropDownButtonItem = UIBarButtonItem(title: nil , image: image, target: self, action: nil, menu: makeDropDownMenu())
        
        /// return logo and button
        return [logoBarButtonItem, dropDownButtonItem]
    }
    
    /// Bar Buttons right
    func makeRightBarButtonItem() -> [UIBarButtonItem] {
        /// Two button
        let addImage = UIImage(systemName: "plus.app")?.withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        let addBarButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(addBarAction))
        
        let directImage = UIImage(systemName: "paperplane")?.withTintColor(UIColor.theme.icons, renderingMode: .alwaysOriginal)
        let directButtonItem = UIBarButtonItem(image: directImage, style: .plain, target: self, action: #selector(directButtonAction))
        
        return [directButtonItem, addBarButtonItem]
    }
    
    /// Bar Item
    func makeDropDownMenu() -> UIMenu {
        
        let subscriberItem = UIAction(title: "Subscribers", image: UIImage(systemName: "person.2")) { _ in }
        
        let favoriteItem = UIAction(title: "Favorite", image: UIImage(systemName: "star")) { _ in }
        
        return UIMenu(children: [subscriberItem, favoriteItem])
    }
    
    /// Right Bar Button Actions
    @objc func addBarAction() {
        print("[⚠️] Add button pressed")
    }
    
    @objc func directButtonAction() {
        print("[⚠️] Direct button pressed")
    }
}

//MARK: TableView DataSource
extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataService[indexPath.row]
        
        switch item {
        case .stories(let story):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StoriesSetCell.self), for: indexPath) as! StoriesSetCell
            cell.configure(with: story)
            return cell
            
        case .post(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as! PostCell
            cell.configure(with: post)
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return view.bounds.height.getCustomRowHeight(with: view.bounds.height)
           } else {
               return UITableView.automaticDimension
           }
 
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return view.bounds.height.getCustomRowHeight(with: view.bounds.height)
           } else {
               return UITableView.automaticDimension
           }
    }
}
