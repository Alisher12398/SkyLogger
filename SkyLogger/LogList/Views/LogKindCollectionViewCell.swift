//
//  LogKindCollectionViewCell.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

class LogKindCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "LogKindCollectionViewCell"
    static var height: CGFloat = 51
    static var offset: CGFloat = 16
    static let labelFont: UIFont = .regular(15)
    
    static func getSize(kind: Log.Kind) -> CGSize {
        return .init(width: (kind.emoji + " " + kind.titleShort).width(font: labelFont) + 4, height: height)
    }
    
    lazy var label: UILabel = {
        let l = UILabel()
        l.textColor = .skyTextWhite
        l.font = LogKindCollectionViewCell.labelFont
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(title: String, isSelected: Bool) {
        makeConstraints()
        label.text = title
        label.textColor = isSelected ? .skyYellow : .skyTextWhite
    }
    
    private func configure() {
        
    }
    
    private func makeConstraints() {
        reAddSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.rightAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
