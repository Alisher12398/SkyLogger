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
        v.backgroundColor = .white
        v.layer.cornerRadius = 12
        v.layer.borderColor = UIColor(hex: "#F1F1F4")?.cgColor
        v.layer.borderWidth = 0.5
        return v
    }()
    
    lazy var emojiLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(14)
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(log: Log) {
        emojiLabel.text = log.kind.emoji
        let fileFiltered: String = String(log.file.split(separator: "/").last ?? "")
        fileRightLabel.text = "\(fileFiltered); \(log.function): \(log.line)"
        
        let infoRightTopLabelText: String? = {
            switch log.kind {
            case .api(data: let data):
                return data.urlPath
            case .custom(key: let key, emoji: _):
                return "Key: " + key
            default:
                if let message = log.message {
                    return "Message: " + String(describing: message)
                } else {
                    return nil
                }
            }
        }()
        infoRightTopLabel.text = infoRightTopLabelText
        
        let infoRightBottomLabelText: String? = {
            switch log.kind {
            case .api(data: let data):
                return String(describing: data.statusCode)
            case .custom:
                if let message = log.message {
                    return "Message: " + String(describing: message)
                } else {
                    if let parameter = log.parameters?.first, let value = parameter.value {
                        return parameter.key + ": " + String(describing: value)
                    } else {
                        return nil
                    }
                }
            default:
                if let parameter = log.parameters?.first, let value = parameter.value {
                    return parameter.key + ": " + String(describing: value)
                } else {
                    return nil
                }
            }
        }()
        infoRightBottomLabel.text = infoRightBottomLabelText
        
        makeConstraints()
    }
    
    private func configure() {
        selectionStyle = .none
        fileLeftLabel.text = "📝 File"
        infoLeftLabel.text = "ℹ️ Info"
    }
    
    private func makeConstraints() {
        cellView.snp.removeConstraints()
        cellView.removeFromSuperview()
        emojiLabel.snp.removeConstraints()
        emojiLabel.removeFromSuperview()
        
        addSubview(cellView)
        cellView.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(LogTableViewCell.cellViewHeight)
        })
        
        cellView.addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        })
        
    }

}
