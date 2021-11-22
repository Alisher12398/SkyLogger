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
    
    private var selectedLogKindIndex: Int = 0 {
        didSet {
            rootView.listTableView.reloadData()
            rootView.logKindCollectionView.reloadData()
        }
    }
    
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
        configure()
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.logKindCollectionView.reloadData()
    }
    
}

//MARK:- @objc Methods
extension LogListViewController {
    
}

//MARK:- Private Methods
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
        let textAttributes = [NSAttributedString.Key.foregroundColor: Customization.shared.secondaryColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}

//MARK:- LogListViewControllerProtocol
extension LogListViewController: LogListViewControllerProtocol {
    
}

//MARK:- UICollectionViewDelegate
extension LogListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedLogKindIndex = indexPath.row
    }
    
}

//MARK:- UICollectionViewDataSource
extension LogListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Log.Kind.allCases.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("sdfsdf row", indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LogKindCollectionViewCell.reuseIdentifier, for: indexPath) as! LogKindCollectionViewCell
        if indexPath.row == 0 {
            cell.setData(title: "Все", isSelected: indexPath.row == selectedLogKindIndex)
        } else if let kind = Log.Kind.allCases[safe: indexPath.row - 1] {
            cell.setData(title: kind.emoji + " " + kind.titleShort, isSelected: indexPath.row == selectedLogKindIndex)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return .init(width: "Все".width(font: LogKindCollectionViewCell.labelFont), height: LogKindCollectionViewCell.height)
        } else if let kind = Log.Kind.allCases[safe: indexPath.row - 1] {
            return LogKindCollectionViewCell.getSize(kind: kind)
        } else {
            return .init(width: 0, height: 0)
        }
    }
    
}

//MARK:- UITableViewDelegate
extension LogListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
//MARK:- UITableViewDataSource
extension LogListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Logger.getLogs().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LogTableViewCell.reuseIdentifier, for: indexPath) as! LogTableViewCell
        
        let filteredLogs: [Log] = {
            if selectedLogKindIndex == 0 {
                return Logger.getLogs()
            } else {
                if let kind = Log.Kind.allCases[safe: selectedLogKindIndex - 1] {
                    return Logger.getLogs().filter({ $0.kind == kind })
                } else {
                    return []
                }
            }
        }()
        if let log = filteredLogs[safe: indexPath.row] {
            cell.setData(log: log, number: indexPath.row + 1, allCountNumber: filteredLogs.count)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LogTableViewCell.height
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
