//
//  LogTableViewCell.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 18.11.2021.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "LogTableViewCell"
    static var height: CGFloat = cellViewHeight + cellOffset
    static var cellViewHeight: CGFloat = yInset + labelMaxHeight + yOffset + labelMaxHeight + yOffset + labelMaxHeight + yInset
    static var cellOffset: CGFloat = 16
    
    private static let labelMaxHeight: CGFloat = 34
    private static let yInset: CGFloat = 8
    private static let yOffset: CGFloat = 10
    private static let iconSize: CGFloat = 18
    
    lazy var cellView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.skyBackgroundLight
        v.layer.cornerRadius = 12
        return v
    }()
    
    lazy var cellViewColorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.blue
        v.layer.cornerRadius = 12
        return v
    }()
    
    lazy var emojiLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .center
        return l
    }()
    
    lazy var fileIconLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .left
        return l
    }()
    
    lazy var infoIconLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .left
        return l
    }()
    
    lazy var fileLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .left
        l.numberOfLines = 2
        return l
    }()
    
    lazy var infoCenterLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .left
        l.numberOfLines = 2
        return l
    }()
    
    lazy var infoBottomLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .left
        l.numberOfLines = 2
        return l
    }()
    
    lazy var countNumberLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(10)
        l.textAlignment = .left
        l.textColor = .skyTextSecondary
        return l
    }()
    
    lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(10)
        l.textAlignment = .right
        l.textColor = .skyTextTertiary
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
        cellViewColorView.backgroundColor = log.kind.color.alpha(0.15)
        emojiLabel.text = log.kind.emoji
        fileLabel.text = SkyStringHandler.getFileLine(log: log, haveSpace: false)
        infoCenterLabel.text = getInfoRightTopLabelText(log: log)
        infoBottomLabel.text = getInfoRightBottomLabelText(log: log)
        countNumberLabel.text = String(number) + "/" + String(allCountNumber)
        dateLabel.text = SkyStringHandler.getDateString(log.date)
        
        makeConstraints()
    }
    
}

//MARK: - UI
private extension LogTableViewCell {
    
    private func configure() {
        backgroundColor = .clear
        selectionStyle = .none
        fileIconLabel.text = "📝"
        infoIconLabel.text = "ℹ️"
    }
    
    private func makeConstraints() {
        reAddSubview(cellView)
        cellView.reAddSubviews([
            cellViewColorView,
            emojiLabel,
            fileIconLabel,
            infoIconLabel,
            fileLabel,
            infoCenterLabel,
            infoBottomLabel,
            countNumberLabel,
            fileLabel,
            dateLabel
        ])
        
        cellView.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(LogTableViewCell.cellViewHeight)
        })
        
        cellViewColorView.snp.makeConstraints({
            $0.left.right.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        })
        
        emojiLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(Self.iconSize)
        })
        
        fileIconLabel.snp.makeConstraints({
            $0.left.equalTo(emojiLabel.snp.right).offset(10)
            $0.centerY.equalTo(fileLabel.snp.centerY)
            $0.width.equalTo(Self.iconSize)
            $0.height.equalTo(Self.iconSize)
        })
        
        fileLabel.addLeftVerticalLine(checkIsEmpty: true)
        fileLabel.snp.makeConstraints({
            $0.left.equalTo(fileIconLabel.snp.right).offset(17)
            $0.right.equalToSuperview().inset(8)
            $0.height.lessThanOrEqualTo(Self.labelMaxHeight)
            $0.top.equalToSuperview().offset(Self.yInset)
        })
        
        infoIconLabel.snp.makeConstraints({
            $0.left.equalTo(fileIconLabel.snp.left)
            $0.centerY.equalTo(infoCenterLabel.snp.centerY)
            $0.width.equalTo(Self.iconSize)
            $0.height.equalTo(Self.iconSize)
        })
        
        infoCenterLabel.addLeftVerticalLine(checkIsEmpty: true)
        infoCenterLabel.snp.makeConstraints({
            $0.left.equalTo(fileLabel.snp.left)
            $0.right.equalToSuperview().offset(-16)
            $0.height.lessThanOrEqualTo(Self.labelMaxHeight)
            $0.centerY.equalToSuperview()
        })
        
        dateLabel.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-Self.yInset)
            $0.width.equalTo(dateLabel.calculateMaxWidth())
        })
        
        infoBottomLabel.addLeftVerticalLine(checkIsEmpty: true)
        infoBottomLabel.snp.makeConstraints({
            $0.left.equalTo(fileLabel.snp.left)
            $0.right.equalTo(dateLabel.snp.left).offset(-10)
            $0.height.equalTo(Self.labelMaxHeight)
            $0.bottom.equalToSuperview().offset(-Self.yInset)
        })
        
        countNumberLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(8)
            $0.right.equalTo(fileIconLabel.snp.right).offset(-4)
            $0.bottom.equalToSuperview().offset(-Self.yInset)
        })
    }
    
}

//MARK: - Private Functions
private extension LogTableViewCell {
    
    private func getInfoRightTopLabelText(log: Log) -> String? {
        var parameters: [Log.Parameter] = log.parameters ?? []
        let result: String? = {
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
        return result
    }
    
    private func getInfoRightBottomLabelText(log: Log) -> String? {
        let parameters: [Log.Parameter] = log.parameters ?? []
        let result: String? = {
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
        return result
    }
    
}
