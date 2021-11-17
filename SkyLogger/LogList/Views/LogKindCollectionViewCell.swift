//
//  LogKindCollectionViewCell.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

class LogKindCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "LogKindCollectionViewCell"
    static var height: CGFloat = 0
    static var offset: CGFloat = 12
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        configure()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData() {
        
    }
    
    private func configure() {
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
    }
    
}
