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
    
    //MARK: Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        items = dataService.arrayFakeDataTypeStoryAndPostForHomeVC
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private properties
    private let tableView = UITableView()
    private var items: [InstagramItemType] = []
    
    //MARK: DataService
    private let dataService = FakeDataService()
}

//MARK: - Private methods
private extension HomeViewController {
    func initialize() {
        /// View
        view.backgroundColor = UIColor(named: "customBackground")
        /// Elements
        setUpBarItems()
        setUpTableView()
    }
}

//MARK: - Bar Items
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
        let image = UIImage(systemName: "homekit")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                  renderingMode: .alwaysOriginal)
        let tabItem = UITabBarItem(title: "", image: image , tag: 0)
        self.tabBarItem = tabItem
    }
    
    /// Bar Button left
    func makeLeftBarButtonItem() -> [UIBarButtonItem] {
        
        /// Add logo mage
        let logoBarButtonItem = UIBarButtonItem(customView: LogoView())
        /// Add bar button
        let image = UIImage(systemName: "chevron.down")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                       renderingMode: .alwaysOriginal)
        let dropDownButtonItem = UIBarButtonItem(title: nil , image: image, target: self, action: nil, menu: makeDropDownMenu())
        
        /// return logo and button
        return [logoBarButtonItem, dropDownButtonItem]
    }
    
    /// Bar Buttons right
    func makeRightBarButtonItem() -> [UIBarButtonItem] {
        /// Two button
        let addImage = UIImage(systemName: "plus.app")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                       renderingMode: .alwaysOriginal)
        let addBarButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(addBarAction))
        
        let directImage = UIImage(systemName: "paperplane")?.withTintColor(UIColor(named: "barItems") ?? .systemGroupedBackground,
                                                                       renderingMode: .alwaysOriginal)
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
        print("Add some")
    }
    @objc func directButtonAction() {
        print("Hello")
    }
}

//MARK: - TableView
private extension HomeViewController {
    
    func setUpTableView() {
        view.addSubview(tableView)
        /// Constraints
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        /// Register  cell
        tableView.register(StoriesSetCell.self, forCellReuseIdentifier: String(describing: StoriesSetCell.self))
        tableView.register(PostCell.self, forCellReuseIdentifier: String(describing: PostCell.self))
    }
}

//MARK: TableView Data Source
extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        switch item {
        case .stories(let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StoriesSetCell.self), for: indexPath) as! StoriesSetCell
            cell.configure(with: info)
            return cell
            
        case .post(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as! PostCell
            cell.configure(with: post)
            return cell
        }
    }
}