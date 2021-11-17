//
//  LogListView.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

class LogListView: BaseView {
    
    lazy var logKindCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout.init()
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.bounces = true
        cv.alwaysBounceVertical = false
        cv.alwaysBounceHorizontal = true
        cv.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        return cv
    }()
    
    lazy var listTableView: UITableView = {
        let tv = UITableView.init(frame: .zero, style: .plain)
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
        addSubview(logKindCollectionView)
        addSubview(listTableView)
    }
    
    func makeConstraints() {
        
    }
    
}

//MARK:- Public Methods
extension LogListView {
    
}

//MARK:- Private Methods
private extension LogListView {
    
}

