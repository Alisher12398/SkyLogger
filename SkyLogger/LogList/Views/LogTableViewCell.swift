//
//  LogTableViewCell.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 18.11.2021.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "LogTableViewCell"
    static var height: CGFloat = cellViewHeight + offset
    static var cellViewHeight: CGFloat = 120
    static var offset: CGFloat = 16
    
    lazy var cellView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.backgroundLight
        v.layer.cornerRadius = 12
        v.layer.borderColor = UIColor.backgroundLight.cgColor
        v.layer.borderWidth = 0.5
        return v
    }()
    
    lazy var emojiLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .center
        return l
    }()
    
    lazy var fileLeftLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .left
        return l
    }()
    
    lazy var infoLeftLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .left
        return l
    }()
    
    lazy var fileRightLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(14)
        l.textAlignment = .left
        l.numberOfLines = 2
        return l
    }()
    
    lazy var infoRightTopLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(14)
        l.textAlignment = .left
        l.numberOfLines = 2
        return l
    }()
    
    lazy var infoRightBottomLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(14)
        l.textAlignment = .left
        return l
    }()
    
    lazy var countNumberLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(10)
        l.textAlignment = .left
        l.textColor = .textSecondary
        return l
    }()
    
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(10)
        l.textAlignment = .right
        l.textColor = .textSecondary
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(log: Log, number: Int, allCountNumber: Int) {
        emojiLabel.text = log.kind.emoji
        fileRightLabel.text = SkyStringHandler.getFileLine(log: log, haveSpace: false)
        
        var parameters = log.parameters ?? []
        
        
        let infoRightTopLabelText: String? = {
            switch log.kind {
            case .api(data: let data):
                return data?.urlPath

            case .custom(key: let key, emoji: _):
                return "Key: " + key
            default:
                if let message = log.message {
                    return "Message: " + String(describing: message)
                } else if let parameter = parameters.first, let value = parameter.value {
                    parameters.removeFirst()
                    return parameter.key + ": " + String(describing: value)
                } else {
                    return nil
                }
            }
        }()
        infoRightTopLabel.text = infoRightTopLabelText
        
        let infoRightBottomLabelText: String? = {
            switch log.kind {
            case .api(data: let data):
                if let statusCode = data?.statusCode {
                    return String(statusCode)
                } else {
                    return nil
                }
            
            case .custom:
                if let message = log.message {
                    return "Message: " + String(describing: message)
                } else {
                    if let parameter = parameters.first, let value = parameter.value {
                        return parameter.key + ": " + String(describing: value)
                    } else {
                        return nil
                    }
                }
            default:
                if let parameter = parameters.first, let value = parameter.value {
                    return parameter.key + ": " + String(describing: value)
                } else {
                    return nil
                }
            }
        }()
        infoRightBottomLabel.text = infoRightBottomLabelText
        
        countNumberLabel.text = String(number) + "/" + String(allCountNumber)
        dateLabel.text = SkyStringHandler.getDateString(log.date)
        
        makeConstraints()
    }
    
    private func configure() {
        backgroundColor = .clear
        selectionStyle = .none
        fileLeftLabel.text = "📝"
        infoLeftLabel.text = "ℹ️"
    }
    
    private func makeConstraints() {
        reAddSubview(cellView)
        cellView.reAddSubviews([
            emojiLabel,
            fileLeftLabel,
            infoLeftLabel,
            fileRightLabel,
            infoRightTopLabel,
            infoRightBottomLabel,
            countNumberLabel,
            fileRightLabel,
            dateLabel
        ])
        
        cellView.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(LogTableViewCell.cellViewHeight)
        })
        
        emojiLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(18)
        })
        
        fileLeftLabel.snp.makeConstraints({
            $0.left.equalTo(emojiLabel.snp.right).offset(10)
            $0.centerY.equalTo(fileRightLabel.snp.centerY)
            $0.width.equalTo(17)
            $0.height.equalTo(17)
        })
        
        fileRightLabel.addLeftVerticalLine(checkIsEmpty: true)
        fileRightLabel.snp.makeConstraints({
            $0.left.equalTo(fileLeftLabel.snp.right).offset(17)
            $0.right.equalToSuperview().inset(8)
            $0.height.lessThanOrEqualTo(34)
            $0.top.equalToSuperview().offset(8)
        })
        
        infoLeftLabel.snp.makeConstraints({
            $0.left.equalTo(fileLeftLabel.snp.left)
            $0.centerY.equalTo(infoRightTopLabel.snp.centerY)
            $0.width.equalTo(fileLeftLabel.snp.width)
            $0.height.equalTo(fileLeftLabel.snp.height)
        })
        
        infoRightTopLabel.addLeftVerticalLine(checkIsEmpty: true)
        infoRightTopLabel.snp.makeConstraints({
            $0.left.equalTo(fileRightLabel.snp.left)
            $0.right.equalToSuperview().offset(-16)
            $0.height.lessThanOrEqualTo(34)
            $0.top.equalTo(fileRightLabel.snp.bottom).offset(10)
        })
        
        infoRightBottomLabel.addLeftVerticalLine(checkIsEmpty: true)
        infoRightBottomLabel.snp.makeConstraints({
            $0.left.equalTo(fileRightLabel.snp.left)
            $0.right.equalTo(dateLabel.snp.left).offset(-16)
            $0.height.equalTo(16)
            $0.bottom.equalToSuperview().offset(-8)
        })
        
        countNumberLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(8)
            $0.right.equalTo(fileLeftLabel.snp.right)
            $0.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(9)
        })
        
        dateLabel.snp.makeConstraints({
            $0.right.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(9)
        })
    }
    
}
