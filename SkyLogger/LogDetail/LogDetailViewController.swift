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
        print("LogDetailViewController deinit")
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
        rootView.setData(text: SkyStringHandler.convertLogToString(log, showDivider: false))
    }
    
}

//MARK: - @objc Methods
extension LogDetailViewController {
    
    @objc
    private func didTapCopyButton(_ sender: UIBarButtonItem) {
        if #available(iOS 13.0, *) {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        } else {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        UIPasteboard.general.string = SkyStringHandler.convertLogToString(log, showDivider: false)
    }
    
}

//MARK: - Private Methods
private extension LogDetailViewController {
    
    private func configureNavigationBar() {
        navigationItem.title = "SkyLogger"
        
        let item = UIBarButtonItem(title: "Copy", style: .plain, target: self, action: #selector(didTapCopyButton(_:)))
        navigationItem.rightBarButtonItem = item
    }
    
}

//MARK: - LogDetailViewControllerProtocol
extension LogDetailViewController: LogDetailViewControllerProtocol {
    
}

