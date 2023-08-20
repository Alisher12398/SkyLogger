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
        
        var title: String {
            switch self {
            case .shareLogList, .shareLog:
                return "Share"
            case .copy:
                return "Copy"
            }
        }
        
        @available(iOS 13.0, *)
        var icon: UIImage? {
            switch self {
            case .shareLogList, .shareLog:
                return UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.SymbolConfiguration(scale: .medium))
            case .copy:
                return UIImage(systemName: "doc.on.doc", withConfiguration: UIImage.SymbolConfiguration(scale: .medium))
            }
        }
    }
    
    private let kind: Kind
    private let vc: UIViewController?
    
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
        }
        if #available(iOS 13.0, *) {
            self.image = kind.icon
        } else {
            self.title = kind.title
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func didTapCopyButton(_ sender: UIBarButtonItem) {
        if #available(iOS 13.0, *) {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        } else {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        switch kind {
        case .copy(log: let log):
            UIPasteboard.general.string = SkyStringHandler.convertLogToString(log, showDivider: false)
        default:
            return
        }
        
    }
    
    @objc
    private func didTapShareButton(_ sender: UIBarButtonItem) {
        switch kind {
        case .shareLogList:
            Logger.shareLogs(vc: self.vc)
        case .shareLog(let log):
            Logger.shareLog(log: log, vc: self.vc)
        case .copy:
            return
        }
    }

}
