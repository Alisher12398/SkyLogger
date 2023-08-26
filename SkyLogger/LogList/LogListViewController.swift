//
//  LogListViewController.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

class LogListViewController: UIViewController {
    
    private let rootView: LogListView
    
    private var selectedLogKindIndex: Int = 0 {
        didSet {
            guard oldValue != selectedLogKindIndex else { return }
            updateFilteredLogs()
            rootView.listTableView.reloadData()
            rootView.logKindCollectionView.reloadData()
            UIImpactFeedbackGenerator.init(style: .light).impactOccurred()
            rootView.logKindCollectionView.scrollToItem(at: .init(row: selectedLogKindIndex, section: 0), at: .left, animated: true)
            if rootView.listTableView.numberOfSections > 0, rootView.listTableView.numberOfRows(inSection: 0) > 0 {
                rootView.listTableView.layoutIfNeeded()
                rootView.listTableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    private var filteredLogs: [Log] = Logger.getLogs()
    private var allLogs: [Log] = Logger.getLogs()
    
    init() {
        self.rootView = LogListView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Logger.print(message: "deinit Logger")
    }
    
}

//MARK: - View Lifecycle
extension LogListViewController {
    
    override func loadView() {
        super.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

//MARK: - @objc Methods
extension LogListViewController {
    
}

//MARK: - Private Methods
private extension LogListViewController {
    
    private func configure() {
        rootView.logKindCollectionView.delegate = self
        rootView.logKindCollectionView.dataSource = self
        rootView.logKindCollectionView.register(LogKindCollectionViewCell.self, forCellWithReuseIdentifier: LogKindCollectionViewCell.reuseIdentifier)
        
        rootView.listTableView.delegate = self
        rootView.listTableView.dataSource = self
        rootView.listTableView.register(LogTableViewCell.self, forCellReuseIdentifier: LogTableViewCell.reuseIdentifier)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "SkyLogger"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.configure()
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = ""
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationItem.rightBarButtonItem = SkyBarButtonItem(kind: .shareLogList, vc: self)
    }
    
    func updateFilteredLogs() {
        var filteredLogsNew: [Log] {
            switch selectedLogKindIndex {
            case 0:
                return Logger.getLogs()
            case Log.Kind.allCasesForCollectionView.count - 1:
                return Logger.getLogs().filter({ $0.customKey != nil })
            default:
                if let kind = Log.Kind.allCases[safe: selectedLogKindIndex - 1] {
                    return Logger.getLogs().filter({ $0.kind == kind })
                } else {
                    return []
                }
            }
        }
        self.filteredLogs = filteredLogsNew
    }
    
}

//MARK: - UICollectionView Protocols
extension LogListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedLogKindIndex = indexPath.row
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Log.Kind.allCasesForCollectionView.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LogKindCollectionViewCell.reuseIdentifier, for: indexPath) as! LogKindCollectionViewCell
        if let data = Log.Kind.allCasesForCollectionView[safe: indexPath.row] {
            cell.setData(title: data.title, emoji: data.emoji, isSelected: indexPath.row == selectedLogKindIndex)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let data = Log.Kind.allCasesForCollectionView[safe: indexPath.row] else {
            return .zero
        }
        return LogKindCollectionViewCell.getSize(title: data.title, emoji: data.emoji)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
}

//MARK: - UITableViewDelegate
extension LogListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let log = filteredLogs[safe: indexPath.row] else { return }
        let vc = LogDetailViewController.init(log: log)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
//MARK: - UITableViewDataSource
extension LogListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LogTableViewCell.reuseIdentifier, for: indexPath) as! LogTableViewCell
        if let log = filteredLogs[safe: indexPath.row] {
            cell.setData(log: log, number: indexPath.row + 1, allCountNumber: filteredLogs.count)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let log = filteredLogs[safe: indexPath.row] {
            return LogTableViewCell.calculateCellViewHeight(log: log) + LogTableViewCell.cellOffset
        } else {
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}
