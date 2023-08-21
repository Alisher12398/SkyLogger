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
    
    deinit {
        Logger.print(message: "LogDetailViewController deinit")
    }
    
}

//MARK: - View Lifecycle
extension LogDetailViewController {
    
    override func loadView() {
        super.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        rootView.setData(text: SkyStringHandler.convertLogToString(log, showDivider: false, destination: .device))
    }
    
}

//MARK: - @objc Methods
extension LogDetailViewController {
    
}

//MARK: - Private Methods
private extension LogDetailViewController {
    
    private func configureNavigationBar() {
        navigationItem.title = "SkyLogger"
        navigationItem.rightBarButtonItems = [SkyBarButtonItem(kind: .shareLog(log: log), vc: self), SkyBarButtonItem(kind: .copy(log: log), vc: self)]
    }
    
}

//MARK: - LogDetailViewControllerProtocol
extension LogDetailViewController: LogDetailViewControllerProtocol {
    
}

