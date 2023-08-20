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
//        configureNavigationBar()
        rootView.setData(text: SkyStringHandler.convertLogToString(log, showDivider: false))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.rightBarButtonItems = []
    }
    
    
    
}

//MARK: - @objc Methods
extension LogDetailViewController {
    
//    @objc
//    private func didTapCopyButton(_ sender: UIBarButtonItem) {
//        if #available(iOS 13.0, *) {
//            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
//        } else {
//            UIImpactFeedbackGenerator(style: .light).impactOccurred()
//        }
//        UIPasteboard.general.string = SkyStringHandler.convertLogToString(log, showDivider: false)
//    }
//
//    @objc
//    private func didTapShareButton(_ sender: UIBarButtonItem) {
//        Logger.shareLog(log: log, vc: self)
//    }
    
}

//MARK: - Private Methods
private extension LogDetailViewController {
    
    private func configureNavigationBar() {
        navigationItem.title = "SkyLogger"
        
//        let copy = UIBarButtonItem(title: "Copy", style: .plain, target: self, action: #selector(didTapCopyButton(_:)))
//        let share = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(didTapShareButton(_:)))
        navigationItem.rightBarButtonItems = [SkyBarButtonItem(kind: .shareLog(log: log), vc: self), SkyBarButtonItem(kind: .copy(log: log), vc: self)]
    }
    
}

//MARK: - LogDetailViewControllerProtocol
extension LogDetailViewController: LogDetailViewControllerProtocol {
    
}

