//
//  LogDetailViewController.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 26.11.2021.
//

import UIKit

protocol LogDetailViewControllerProtocol {
    
}

class LogDetailViewController: UIViewController {
    
    private let rootView: LogDetailView
    private let log: Log
    
    init(log: Log) {
        self.rootView = LogDetailView()
        self.log = log
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK:- View Lifecycle
extension LogDetailViewController {
    
    override func loadView() {
        super.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        rootView.setData(text: StringHandler.convertLogToString(log))
    }
    
}

//MARK:- @objc Methods
extension LogDetailViewController {
    
}

//MARK:- Private Methods
private extension LogDetailViewController {
    
    private func configureNavigationBar() {
        navigationItem.title = "SkyLogger"
        navigationController?.isNavigationBarHidden = false
    }
    
}

//MARK:- LogDetailViewControllerProtocol
extension LogDetailViewController: LogDetailViewControllerProtocol {
    
}

