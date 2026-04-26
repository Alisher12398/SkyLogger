//
//  Log.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 08.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import UIKit

public class Log: Hashable {

    public static func == (lhs: Log, rhs: Log) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    let kind: Kind
    let customKey: CustomKey?
    let messageString: String?
    let parameters: [Parameter]
    let file: String
    let function: String
    let line: String
    let date: Date

    /// Lowercased text representation, built once on first search query. Read on main thread only.
    private lazy var searchableLowercasedString: String = SkyStringHandler
        .convertLogToString(self, showDivider: false, destination: .device)
        .lowercased()
    
    /**
     Creates a log.
     */
    public convenience init(
        kind: Log.Kind,
        message: Any? = nil,
        parameters: Log.Parameter...,
        customKey: CustomKey? = nil,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        self.init(kind: kind, message: message, parameters: parameters, customKey: customKey, file: file, function: function, line: line)
    }
    
    /**
     Creates a log.
     */
    public init(
        kind: Log.Kind,
        message: Any? = nil,
        parameters: [Log.Parameter] = [],
        customKey: CustomKey? = nil,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        self.id = UUID().uuidString
        self.kind = kind
        self.messageString = SkyStringHandler.convertAnyToString(message)
        self.parameters = parameters
        self.customKey = customKey
        self.file = file
        self.function = function
        self.line = String(line)
        self.date = Date()
    }
    
    func containsText(lowercased: String) -> Bool {
        guard !lowercased.isEmpty else { return true }
        return searchableLowercasedString.contains(lowercased)
    }
    
}

//MARK: - Enums And Classes
extension Log {
    
    public class CustomKey {
        let title: String
        let emoji: Character
        
        var emojiString: String {
            return String(emoji)
        }
        
        public init(title: String, emoji: Character = "🟣") {
            self.title = title
            self.emoji = emoji
        }
        
    }
    
    enum LineKind: CaseIterable {
        case file
        case info
        
        private var title: String {
            switch self {
            case .file:
                return "File"
            case .info:
                return "Info"
            }
        }
        
        var iconForXcode: String {
            switch self {
            case .file:
                return "􀫊"
            case .info:
                return "􀅴"
            }
        }
        
        var iconForDevice: UIImage? {
            switch self {
            case .file:
                return UIImage(systemName: "swift", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
            case .info:
                return UIImage(systemName: "info.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
            }
        }
        
        var iconForShare: String {
            switch self {
            case .file:
                return "📄"
            case .info:
                return "ℹ️"
            }
        }
        
        func getFormattedTitle(destination: SkyStringHandler.LogDetailDestination) -> String {
            var result: String = ""
            result.append(SkyStringHandler.getTabSpace(repeatCount: 1, newLine: true, showDivider: true))
            switch destination {
            case .device:
                result.append(iconForShare)
            case .xcode:
                result.append(iconForXcode)
            case .share:
                result.append(iconForShare)
            }
            result.append(" ")
            result.append(self.title)
            return result
        }
        
    }
    
}



