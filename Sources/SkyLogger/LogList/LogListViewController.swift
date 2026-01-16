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
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.reloadData()
                self.rootView.logKindCollectionView.reloadData()
                UIImpactFeedbackGenerator.init(style: .light).impactOccurred()
                self.rootView.logKindCollectionView.scrollToItem(at: .init(row: self.selectedLogKindIndex, section: 0), at: .left, animated: true)
                if self.rootView.listTableView.numberOfSections > 0, self.rootView.listTableView.numberOfRows(inSection: 0) > 0 {
                    self.rootView.listTableView.layoutIfNeeded()
                    self.rootView.listTableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
                }
            }
        }
    }
    
    private let parentStatusBarColor: UIColor?
    
    private var filteredLogs: [Log] = Logger.getLogs()
    
    private lazy var allLogs: [Log] = fetchLogs() {
        didSet {
            reloadData()
        }
    }
    
    private var searchBarText: String? = nil {
        didSet {
            updateLogs()
        }
    }
    
    init() {
        self.parentStatusBarColor = UIApplication.shared.statusBarUIView?.backgroundColor
        self.rootView = LogListView()
        super.init(nibName: nil, bundle: nil)
        print("parentStatusBarColor", self.parentStatusBarColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Logger.print(message: "deinit Logger")
        NotificationCenter.default.removeObserver(self, name: .newLogAdded, object: nil)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(newLogAddedNotification(_:)), name: .newLogAdded, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tapGesture.cancelsTouchesInView = false
        rootView.listTableView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let parentStatusBarColor {
            setStatusBar(color: parentStatusBarColor)
        }
    }
    
}

//MARK: - @objc Methods
extension LogListViewController {
    
    @objc
    private func newLogAddedNotification(_ sender: Notification) {
        updateLogs()
    }
    
    @objc
    private func dismissKeyboard(_ sender: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
}

//MARK: - Private Methods
private extension LogListViewController {
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.updateFilteredLogs()
            self.rootView.listTableView.reloadData()
        }
    }
    
    private func configure() {
        rootView.logKindCollectionView.delegate = self
        rootView.logKindCollectionView.dataSource = self
        rootView.logKindCollectionView.register(LogKindCollectionViewCell.self, forCellWithReuseIdentifier: LogKindCollectionViewCell.reuseIdentifier)
        
        rootView.listTableView.delegate = self
        rootView.listTableView.dataSource = self
        rootView.listTableView.register(LogTableViewCell.self, forCellReuseIdentifier: LogTableViewCell.reuseIdentifier)
        
        rootView.searchBar.delegate = self
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "SkyLogger"
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.configure()
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = ""
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationItem.rightBarButtonItems = [
            SkyBarButtonItem(kind: .shareLogList, vc: self),
            SkyBarButtonItem(kind: .changeSortType, vc: self)
        ]
        if let _ = parentStatusBarColor {
            setStatusBarClear()
        }
    }
    
    func updateFilteredLogs() {
        var filteredLogsNew: [Log] = {
            switch selectedLogKindIndex {
            case 0:
                return allLogs
            case Log.Kind.allCasesForCollectionView.count - 1:
                return allLogs.filter({ $0.customKey != nil })
            default:
                if let kind = Log.Kind.allCases[safe: selectedLogKindIndex - 1] {
                    return allLogs.filter({ $0.kind == kind })
                } else {
                    return []
                }
            }
        }()
        if let searchBarText, !searchBarText.isEmpty {
            filteredLogsNew = filteredLogsNew.filter({ $0.containsText(searchBarText) })
        }
        self.filteredLogs = filteredLogsNew
    }
    
    private func fetchLogs() -> [Log] {
        return Logger.getLogs()
    }
    
    private func updateLogs() {
        self.allLogs = fetchLogs()
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
            let number: Int = {
                switch SkyConfiguration.shared.sortType {
                case .newOnTop:
                    return allLogs.count - (allLogs.firstIndex(of: log) ?? 0)
                case .newOnBottom:
                    return (allLogs.firstIndex(of: log) ?? 0) + 1
                }
            }()
            cell.setData(log: log, number: number, allCountNumber: allLogs.count)
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

//MARK: - UISearchBarDelegate
extension LogListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBarText = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
