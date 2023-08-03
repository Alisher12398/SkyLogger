//
//  LogTableViewCell.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 18.11.2021.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "LogTableViewCell"
    static func getCellViewHeight(log: Log) -> CGFloat {
        var result: CGFloat = 0
        result += yInset
        result += multilineLabelMaxHeight
        result += yOffset
        result += bottomLabelHeight
        result += yInset
        if Self.isLogHaveMessage(log) {
            result += yOffset
            result += singlelineLabelMaxHeight
        }
        if Self.isLogHaveParameters(log) {
            result += yOffset
            result += singlelineLabelMaxHeight
        }
        return result
    }
    static var cellOffset: CGFloat = 16
    
    private static let singlelineLabelMaxHeight: CGFloat = 15
    private static let multilineLabelMaxHeight: CGFloat = 30
    private static let yInset: CGFloat = 8
    private static let yOffset: CGFloat = 8
    private static let iconSize: CGFloat = 16
    private static let bottomLabelHeight: CGFloat = 12
    
    private var log: Log? = nil
    
    lazy var cellView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.skyBackgroundLight
        v.layer.cornerRadius = 12
        return v
    }()
    
    lazy var cellViewColorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        v.layer.cornerRadius = 12
        return v
    }()
    
    lazy var emojiLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(10)
        l.textAlignment = .center
        return l
    }()
    
    lazy var fileIconImageView: UIImageView = {
        let imaveView = UIImageView()
        imaveView.layer.masksToBounds = true
        imaveView.tintColor = .gray
        imaveView.contentMode = .scaleAspectFit
        return imaveView
    }()
    
    lazy var messageIconImageView: UIImageView = {
        let imaveView = UIImageView()
        imaveView.layer.masksToBounds = true
        imaveView.tintColor = .gray
        imaveView.contentMode = .scaleAspectFit
        return imaveView
    }()
    
    lazy var parametersIconImageView: UIImageView = {
        let imaveView = UIImageView()
        imaveView.layer.masksToBounds = true
        imaveView.tintColor = .gray
        imaveView.contentMode = .scaleAspectFit
        return imaveView
    }()
    
    lazy var fileTopLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .left
        l.numberOfLines = 2
        return l
    }()
    
    lazy var messageCenterLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .left
        l.numberOfLines = 1
        return l
    }()
    
    lazy var parametersBottomLabel: UILabel = {
        let l = UILabel()
        l.font = .regular(12)
        l.textAlignment = .left
        l.numberOfLines = 1
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
        self.log = log
        cellViewColorView.backgroundColor = log.kind.color.alpha(0.15)
        emojiLabel.text = log.kind.emoji
        fileTopLabel.text = Self.getFileLabelText(log: log)
        messageCenterLabel.text = Self.getMessageLabelText(log: log)
        parametersBottomLabel.text = Self.getParametersLabelText(log: log)
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
        if #available(iOS 13.0, *) {
            fileIconImageView.image = UIImage(systemName: "swift", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
            messageIconImageView.image = UIImage(systemName: "text.bubble", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
            parametersIconImageView.image = UIImage(systemName: "info.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func makeConstraints() {
        guard let log = log else { return }
        let isHaveMessage = Self.isLogHaveMessage(log)
        let isHaveParameters = Self.isLogHaveParameters(log)
        
        let subviews: [UIView] = [cellViewColorView,
                                  emojiLabel,
                                  fileIconImageView,
                                  fileTopLabel,
                                  countNumberLabel,
                                  fileTopLabel,
                                  dateLabel,
        ]
        let optionalSubviews: [UIView] = [
            messageIconImageView,
            messageCenterLabel,
            parametersIconImageView,
            parametersBottomLabel
        ]
        
        let allSubviews: [UIView] = subviews + optionalSubviews
        
        removeSubview(cellView)
        removeSubviews(allSubviews)
        
        reAddSubview(cellView)
        cellView.reAddSubviews([
            cellViewColorView,
            emojiLabel,
            fileIconImageView,
            fileTopLabel,
            countNumberLabel,
            fileTopLabel,
            dateLabel
        ])
        if isHaveMessage {
            cellView.reAddSubviews([
                messageIconImageView,
                messageCenterLabel
            ])
        }
        if isHaveParameters {
            cellView.reAddSubviews([
                parametersIconImageView,
                parametersBottomLabel
            ])
        }
        
        cellView.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(LogTableViewCell.getCellViewHeight(log: log))
        })
        
        cellViewColorView.snp.makeConstraints({
            $0.left.right.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        })
        
        emojiLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(8)
            $0.top.equalToSuperview().offset(Self.yOffset)
            $0.width.height.equalTo(emojiLabel.calculateMaxWidth())
        })
        
        fileIconImageView.snp.makeConstraints({
            $0.left.equalTo(emojiLabel.snp.right).offset(8)
            $0.centerY.equalTo(fileTopLabel.snp.centerY)
            $0.width.equalTo(Self.iconSize)
            $0.height.equalTo(Self.iconSize)
        })
        
        fileTopLabel.addLeftVerticalLine(checkIsEmpty: true)
        fileTopLabel.snp.makeConstraints({
            $0.left.equalTo(fileIconImageView.snp.right).offset(12)
            $0.right.equalToSuperview().inset(8)
            $0.height.lessThanOrEqualTo(Self.multilineLabelMaxHeight)
            $0.top.equalToSuperview().offset(Self.yInset)
        })
        
        if isHaveMessage {
            messageIconImageView.snp.makeConstraints({
                $0.left.equalTo(fileIconImageView.snp.left)
                $0.centerY.equalTo(messageCenterLabel.snp.centerY)
                $0.width.equalTo(Self.iconSize)
                $0.height.equalTo(Self.iconSize)
            })
            
            messageCenterLabel.addLeftVerticalLine(checkIsEmpty: true)
            messageCenterLabel.snp.makeConstraints({
                $0.left.equalTo(fileTopLabel.snp.left)
                $0.right.equalToSuperview().offset(-16)
                $0.height.lessThanOrEqualTo(Self.singlelineLabelMaxHeight)
                $0.top.equalTo(fileTopLabel.snp.bottom).offset(Self.yOffset)
            })
        }
        
        dateLabel.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-Self.yInset)
            $0.width.equalTo(dateLabel.calculateMaxWidth())
            $0.height.equalTo(Self.bottomLabelHeight)
        })
        
        if isHaveParameters {
            parametersIconImageView.snp.makeConstraints({
                $0.left.equalTo(fileIconImageView.snp.left)
                $0.centerY.equalTo(parametersBottomLabel.snp.centerY)
                $0.width.equalTo(Self.iconSize)
                $0.height.equalTo(Self.iconSize)
            })
            
            parametersBottomLabel.addLeftVerticalLine(checkIsEmpty: true)
            parametersBottomLabel.snp.makeConstraints({
                $0.left.equalTo(fileTopLabel.snp.left)
                $0.right.equalToSuperview().offset(-8)
                $0.height.equalTo(Self.singlelineLabelMaxHeight)
                $0.top.equalTo(isHaveMessage ? messageCenterLabel.snp.bottom : fileTopLabel.snp.bottom).offset(Self.yOffset)
            })
        }
        
        countNumberLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(8)
            $0.right.equalTo(fileIconImageView.snp.right).offset(-4)
            $0.bottom.equalToSuperview().offset(-Self.yInset)
            $0.height.equalTo(Self.bottomLabelHeight)
        })
    }
    
}

//MARK: - Private Functions
private extension LogTableViewCell {
    
    private static func isLogHaveMessage(_ log: Log) -> Bool {
        return getMessageLabelText(log: log) != nil
    }
    
    private static func isLogHaveParameters(_ log: Log) -> Bool {
        return getParametersLabelText(log: log) != nil
    }
    
    private static func getFileLabelText(log: Log) -> String? {
        let fileName = SkyStringHandler.getFileLine(log: log, haveSpace: false)
        switch log.kind {
        case .custom(key: let key, emoji: _):
            return "Key: " + key + ".    " + fileName
        default:
            return fileName
        }
    }
    
    private static func getMessageLabelText(log: Log) -> String? {
        switch log.kind {
        case .api(data: let data):
            return data?.urlPath
        default:
            if let result = log.message as? String, !result.isEmpty {
                return result
            } else {
                return nil
            }
        }
    }
    
    private static func getParametersLabelText(log: Log) -> String? {
        let parameters: [Log.Parameter] = log.parameters ?? []
        switch log.kind {
        case .api(data: let data):
            if let statusCode = data?.statusCode {
                return String(statusCode)
            } else {
                return nil
            }
        default:
            guard !parameters.isEmpty else { return nil }
            var result: String = ""
            if let parameter = parameters.first, let string = getParameterString(parameter) {
                result += string
            }
            if let parameter = parameters[safe: 1], let string = getParameterString(parameter) {
                result += ", "
                result += string
            }
            return result
        }
    }
    
    private static func getParameterString(_ parameter: Log.Parameter) -> String? {
        if let value = parameter.value {
            return "\"\(parameter.key)\"" + ": " + String(describing: value)
        } else {
            return nil
        }
    }
    
}
