//
//  LogTableViewCellabel.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 18.11.2021.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "LogTableViewCell"
    static func calculateCellViewHeight(log: Log) -> CGFloat {
        var result: CGFloat = 0
        result += yInset
        result += multilineLabelMaxHeight
        result += yOffset
        result += bottomLabelHeight
        result += yInset
        if Self.isCellHaveInfoCenterLabel(log) {
            result += yOffset
            result += singlelineLabelMaxHeight
        }
        if Self.isCellHaveInfoBottomLabel(log) {
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
    
    //    private var log: Log? = nil
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.skyBackgroundLight
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cellViewColorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(10)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var fileIconImageView: UIImageView = {
        let imaveView = UIImageView()
        imaveView.layer.masksToBounds = true
        imaveView.tintColor = .gray
        imaveView.contentMode = .scaleAspectFit
        imaveView.translatesAutoresizingMaskIntoConstraints = false
        return imaveView
    }()
    
    lazy var infoCenterIconImageView: UIImageView = {
        let imaveView = UIImageView()
        imaveView.layer.masksToBounds = true
        imaveView.tintColor = .gray
        imaveView.contentMode = .scaleAspectFit
        imaveView.translatesAutoresizingMaskIntoConstraints = false
        return imaveView
    }()
    
    lazy var infoBottomIconImageView: UIImageView = {
        let imaveView = UIImageView()
        imaveView.layer.masksToBounds = true
        imaveView.tintColor = .gray
        imaveView.contentMode = .scaleAspectFit
        imaveView.translatesAutoresizingMaskIntoConstraints = false
        return imaveView
    }()
    
    lazy var fileTopLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(12)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var infoCenterLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(12)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var infoBottomLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(12)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var countNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(10)
        label.textAlignment = .left
        label.textColor = .skyTextSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .regular(10)
        label.textAlignment = .right
        label.textColor = .skyTextTertiary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(log: Log, number: Int, allCountNumber: Int) {
        cellViewColorView.backgroundColor = log.kind.color.alpha(0.15)
        emojiLabel.text = log.kind.emoji
        fileTopLabel.text = Self.getFileLabelText(log: log)
        infoCenterLabel.text = Self.getInfoCenterLabelText(log: log)
        infoBottomLabel.text = Self.getInfoBottomLabelText(log: log)
        countNumberLabel.text = String(number) + "/" + String(allCountNumber)
        dateLabel.text = SkyStringHandler.getDateString(log.date)
        
        updateConstraints(log: log)
    }
    
}

//MARK: - UI
private extension LogTableViewCell {
    
    private func configure() {
        backgroundColor = .clear
        selectionStyle = .none
        if #available(iOS 13.0, *) {
            fileIconImageView.image = Log.LineKind.file.iconForDevice
            infoCenterIconImageView.image = UIImage(systemName: "text.bubble", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
            infoBottomIconImageView.image = UIImage(systemName: "info.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func makeConstraints() {
        let subviews: [UIView] = [cellViewColorView,
                                  emojiLabel,
                                  fileIconImageView,
                                  fileTopLabel,
                                  countNumberLabel,
                                  fileTopLabel,
                                  dateLabel,
                                  infoCenterIconImageView,
                                  infoCenterLabel,
                                  infoBottomIconImageView,
                                  infoBottomLabel
        ]
        addSubview(cellView)
        subviews.forEach({
            cellView.addSubview($0)
        })
        
        let mainConstraints: [NSLayoutConstraint] = [
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Self.cellOffset),
            
            cellViewColorView.leftAnchor.constraint(equalTo: cellView.leftAnchor),
            cellViewColorView.rightAnchor.constraint(equalTo: cellView.rightAnchor),
            cellViewColorView.topAnchor.constraint(equalTo: cellView.topAnchor),
            cellViewColorView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            
            emojiLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 8),
            emojiLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: Self.yOffset),
            emojiLabel.widthAnchor.constraint(equalToConstant: 14),
            emojiLabel.heightAnchor.constraint(equalToConstant: 12),
        ]
        
        let fileTopLabelConstraints: [NSLayoutConstraint] = [
            fileIconImageView.leftAnchor.constraint(equalTo: emojiLabel.rightAnchor, constant: 8),
            fileIconImageView.centerYAnchor.constraint(equalTo: fileTopLabel.centerYAnchor),
            fileIconImageView.widthAnchor.constraint(equalToConstant: Self.iconSize),
            fileIconImageView.heightAnchor.constraint(equalToConstant: Self.iconSize),
            
            fileTopLabel.leftAnchor.constraint(equalTo: fileIconImageView.rightAnchor, constant: 12),
            fileTopLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -8),
            fileTopLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: Self.yInset),
            fileTopLabel.heightAnchor.constraint(equalToConstant: Self.multilineLabelMaxHeight),
        ]
        
        let infoCenterLabelConstraints: [NSLayoutConstraint] = [
            infoCenterIconImageView.leftAnchor.constraint(equalTo: fileIconImageView.leftAnchor),
            infoCenterIconImageView.centerYAnchor.constraint(equalTo: infoCenterLabel.centerYAnchor),
            infoCenterIconImageView.widthAnchor.constraint(equalToConstant: Self.iconSize),
            infoCenterIconImageView.heightAnchor.constraint(equalToConstant: Self.iconSize),
            
            infoCenterLabel.leftAnchor.constraint(equalTo: fileTopLabel.leftAnchor),
            infoCenterLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -16),
            infoCenterLabel.topAnchor.constraint(equalTo: fileTopLabel.bottomAnchor, constant: Self.yOffset),
            infoCenterLabel.heightAnchor.constraint(equalToConstant: Self.singlelineLabelMaxHeight)
        ]
        
        let infoBottomLabelConstraints: [NSLayoutConstraint] = [
            infoBottomIconImageView.leftAnchor.constraint(equalTo: fileIconImageView.leftAnchor),
            infoBottomIconImageView.centerYAnchor.constraint(equalTo: infoBottomLabel.centerYAnchor),
            infoBottomIconImageView.widthAnchor.constraint(equalToConstant: Self.iconSize),
            infoBottomIconImageView.heightAnchor.constraint(equalToConstant: Self.iconSize),
            
            infoBottomLabel.leftAnchor.constraint(equalTo: fileTopLabel.leftAnchor),
            infoBottomLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -8),
            infoBottomLabel.topAnchor.constraint(equalTo: infoCenterLabel.bottomAnchor, constant: Self.yOffset),
            infoBottomLabel.heightAnchor.constraint(equalToConstant: Self.singlelineLabelMaxHeight)
        ]
        
        let bottomLabelsContraints: [NSLayoutConstraint] = [
            dateLabel.leftAnchor.constraint(equalTo: cellView.centerXAnchor),
            dateLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -Self.yOffset),
            dateLabel.heightAnchor.constraint(equalToConstant: Self.bottomLabelHeight),
            
            countNumberLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 8),
            countNumberLabel.rightAnchor.constraint(equalTo: cellView.centerXAnchor),
            countNumberLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -Self.yOffset),
            countNumberLabel.heightAnchor.constraint(equalToConstant: Self.bottomLabelHeight),
        ]
        
        let constraints: [NSLayoutConstraint] = mainConstraints + fileTopLabelConstraints + infoCenterLabelConstraints + infoBottomLabelConstraints + bottomLabelsContraints
        
        NSLayoutConstraint.activate(constraints)
        fileTopLabel.addLeftVerticalLine(checkIsEmpty: false)
        infoCenterLabel.addLeftVerticalLine(checkIsEmpty: false)
        infoBottomLabel.addLeftVerticalLine(checkIsEmpty: false)
    }
    
    private func updateConstraints(log: Log) {
        let isCellHaveInfoCenterLabel = Self.isCellHaveInfoCenterLabel(log)
        infoCenterLabel.isHidden = !isCellHaveInfoCenterLabel
        infoCenterIconImageView.isHidden = !isCellHaveInfoCenterLabel
        
        let isCellHaveInfoBottomLabel = Self.isCellHaveInfoBottomLabel(log)
        infoBottomLabel.isHidden = !isCellHaveInfoBottomLabel
        infoBottomIconImageView.isHidden = !isCellHaveInfoBottomLabel
    }
    
}

//MARK: - Private Functions
private extension LogTableViewCell {
    
    private static func isCellHaveInfoCenterLabel(_ log: Log) -> Bool {
        return isLogHaveMessage(log) || isLogHaveParameters(log)
    }
    
    private static func isCellHaveInfoBottomLabel(_ log: Log) -> Bool {
        return isLogHaveMessage(log) && isLogHaveParameters(log)
    }
    
    
    private static func isLogHaveMessage(_ log: Log) -> Bool {
        guard let message = getLogMessageText(log: log), !message.isEmpty else {
            return false
        }
        return true
    }
    
    private static func isLogHaveParameters(_ log: Log) -> Bool {
        guard let parameters = getLogParametersText(log: log), !parameters.isEmpty else {
            return false
        }
        return true
    }
    
    private static func getFileLabelText(log: Log) -> String? {
        let fileName = SkyStringHandler.getFileLine(log: log, haveSpace: false, showDivider: false)
        switch log.kind {
        case .custom(key: let key, emoji: _):
            return "Key: " + key + ".    " + fileName
        default:
            return fileName
        }
    }
    
    private static func getInfoCenterLabelText(log: Log) -> String? {
        if let message = getLogMessageText(log: log) {
            return message
        } else if let parameters = getLogParametersText(log: log) {
            return parameters
        } else {
            return nil
        }
    }
    
    private static func getInfoBottomLabelText(log: Log) -> String? {
        return getLogParametersText(log: log)
    }
    
    private static func getLogMessageText(log: Log) -> String? {
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
    
    private static func getLogParametersText(log: Log) -> String? {
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
            if let parameter = parameters.first, let string = getSubstringForLogParameter(parameter) {
                result += string
            }
            if let parameter = parameters[safe: 1], let string = getSubstringForLogParameter(parameter) {
                result += ", "
                result += string
            }
            return result
        }
    }
    
    private static func getSubstringForLogParameter(_ parameter: Log.Parameter) -> String? {
        if let value = parameter.value {
            return "\"\(parameter.key)\"" + ": " + String(describing: value)
        } else {
            return nil
        }
    }
    
}
