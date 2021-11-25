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
        return cv
    }()
    
    lazy var listTableView: UITableView = {
        let tv = UITableView.init(frame: .zero, style: .plain)
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
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

//MARK:- BaseViewProtocol
extension LogListView: BaseViewProtocol {
    
    func configure() {
        backgroundColor = UIColor.background
        addSubview(logKindCollectionView)
        addSubview(listTableView)
    }
    
    func makeConstraints() {
        logKindCollectionView.snp.makeConstraints({
            $0.left.right.equalToSuperview()
            $0.top.equalTo(safeArea.top)
            $0.height.equalTo(LogKindCollectionViewCell.height)
        })
        
        listTableView.snp.makeConstraints({
            $0.top.equalTo(logKindCollectionView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
    
}

//MARK:- Public Methods
extension LogListView {
    
}

//MARK:- Private Methods
private extension LogListView {
    
}

