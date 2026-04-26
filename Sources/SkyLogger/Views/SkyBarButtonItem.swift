//
//  SkyBarButtonItem.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 19.08.2023.
//

import UIKit

class SkyBarButtonItem: UIBarButtonItem {
    
    enum Kind {
        case shareLogList
        case shareLog(log: Log)
        case copy(log: Log)
        case changeSortType
        
        var icon: UIImage? {
            let systemName: String = {
                switch self {
                case .shareLogList, .shareLog:
                    return "square.and.arrow.up"
                case .copy:
                    return "doc.on.doc"
                case .changeSortType:
                    return "arrow.up.arrow.down"
                }
            }()
            return UIImage(systemName: systemName, withConfiguration: UIImage.SymbolConfiguration(scale: .medium))
        }
    }
    
    private let kind: Kind
    private weak var vc: UIViewController?
    
    init(kind: Kind, vc: UIViewController?) {
        self.kind = kind
        self.vc = vc
        super.init()
        self.target = self
        switch kind {
        case .copy:
            self.action = #selector(didTapCopyButton(_:))
        case .shareLogList, .shareLog:
            self.action = #selector(didTapShareButton(_:))
        case .changeSortType:
            self.action = #selector(didTapChangeSortType(_:))
        }
        self.image = kind.icon
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapCopyButton(_ sender: UIBarButtonItem) {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        switch kind {
        case .copy(log: let log):
            UIPasteboard.general.string = SkyStringHandler.convertLogToString(log, showDivider: false, destination: .share)
        default:
            return
        }
        
    }
    
    @objc
    private func didTapShareButton(_ sender: UIBarButtonItem) {
        switch kind {
        case .shareLogList:
            ()
            Logger.shareLogList(presentingViewController: self.vc)
        case .shareLog(let log):
            Logger.shareLog(log: log, presentingViewController: self.vc)
        case .copy, .changeSortType:
            return
        }
    }
    
    @objc
    private func didTapChangeSortType(_ sender: UIBarButtonItem) {
        SkyConfiguration.shared.toggleSortType()
    }
    
}
