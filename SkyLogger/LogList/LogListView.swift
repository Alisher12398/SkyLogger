//
//  LogListView.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

class LogListView: BaseView {
    
    lazy var logKindCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 24
        layout.minimumLineSpacing = 24
        layout.scrollDirection = .horizontal
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.bounces = true
        cv.alwaysBounceVertical = false
        cv.alwaysBounceHorizontal = true
        cv.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var listTableView: UITableView = {
        let tv = UITableView.init(frame: .zero, style: .plain)
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.indicatorStyle = .white
        tv.showsVerticalScrollIndicator = true
        tv.showsHorizontalScrollIndicator = false
        tv.bounces = true
        tv.alwaysBounceVertical = true
        tv.alwaysBounceHorizontal = false
        tv.estimatedRowHeight = 105
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override init() {
        super.init()
        configure()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - BaseViewProtocol
extension LogListView: BaseViewProtocol {
    
    func configure() {
        backgroundColor = UIColor.skyBackground
        addSubview(logKindCollectionView)
        addSubview(listTableView)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            logKindCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            logKindCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            logKindCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logKindCollectionView.heightAnchor.constraint(equalToConstant: LogKindCollectionViewCell.height),
            
            listTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            listTableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            listTableView.topAnchor.constraint(equalTo: logKindCollectionView.bottomAnchor),
            listTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

//MARK: - Public Methods
extension LogListView {
    
}

//MARK: - Private Methods
private extension LogListView {
    
}

