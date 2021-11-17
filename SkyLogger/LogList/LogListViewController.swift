//
//  LogListViewController.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

protocol LogListViewControllerProtocol {
    
}

class LogListViewController: UIViewController {
    
    let rootView: LogListView
    private let presenter: LogListPresenter
    
    init() {
        self.rootView = LogListView()
        self.presenter = LogListPresenter()
        super.init(nibName: nil, bundle: nil)
        presenter.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- View Lifecycle
extension LogListViewController {
    
    override func loadView() {
        super.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SkyLogger"
        navigationController?.isNavigationBarHidden = true
    }
    
}

//MARK:- @objc Methods
extension LogListViewController {
    
}

//MARK:- Private Methods
private extension LogListViewController {
    
}

//MARK:- LogListViewControllerProtocol
extension LogListViewController: LogListViewControllerProtocol {
    
}

