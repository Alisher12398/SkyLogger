//
//  Log.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 08.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import UIKit

public class Log {
    
    let kind: Kind
    let customKey: CustomKey?
    let message: CustomStringConvertible?
    let parameters: [Parameter]?
    let file: String
    let function: String
    let line: String
    let date: Date
    
    public convenience init(kind: Log.Kind, customKey: CustomKey? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        self.init(logKind: kind, message: nil, parameters: nil, customKey: customKey, file: file, function: function, line: line)
    }
    
    /**
     Creates a log.
     You can use `'Logger.convertObjectToString()'` func to convert non-CustomStringConvertible class/struct object to String.
     */
    public convenience init(kind: Log.Kind, message: CustomStringConvertible?, customKey: CustomKey? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        self.init(logKind: kind, message: message, parameters: nil, customKey: customKey, file: file, function: function, line: line)
    }
    
    /**
     Creates a log.
     You can use `'Logger.convertObjectToString()'` func to convert non-CustomStringConvertible class/struct object to String.
     */
    public convenience init(kind: Log.Kind, parameters: Log.Parameter, customKey: CustomKey? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        self.init(logKind: kind, message: nil, parameters: [parameters], customKey: customKey, file: file, function: function, line: line)
    }
    
    /**
     Creates a log.
     You can use `'Logger.convertObjectToString()'` func to convert non-CustomStringConvertible class/struct object to String.
     */
    public convenience init(kind: Log.Kind, parameters: [Log.Parameter], customKey: CustomKey? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        self.init(logKind: kind, message: nil, parameters: parameters, customKey: customKey, file: file, function: function, line: line)
    }
    
    /**
     Creates a log.
     You can use `'Logger.convertObjectToString()'` func to convert non-CustomStringConvertible class/struct object to String.
     */
    public convenience init(kind: Log.Kind, message: CustomStringConvertible?, parameters: Log.Parameter, customKey: CustomKey? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        self.init(logKind: kind, message: message, parameters: [parameters], customKey: customKey, file: file, function: function, line: line)
    }
    
    /**
     Creates a log.
     You can use `'Logger.convertObjectToString()'` func to convert non-CustomStringConvertible class/struct object to String.
     */
    public convenience init(kind: Log.Kind, message: CustomStringConvertible?, parameters: [Log.Parameter], customKey: CustomKey? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        self.init(logKind: kind, message: message, parameters: parameters, customKey: customKey, file: file, function: function, line: line)
    }
    
    /**
     Creates a log.
     You can use `'Logger.convertObjectToString()'` func to convert non-CustomStringConvertible class/struct object to String.
     */
    private init(logKind: Log.Kind, message: CustomStringConvertible?, parameters: [Log.Parameter]?, customKey: CustomKey?, file: String, function: String, line: Int) {
        self.kind = logKind
        self.message = message
        self.parameters = parameters
        self.customKey = customKey
        self.file = file
        self.function = function
        self.line = String(line)
        self.date = Date()
    }
    
}

//MARK: - Log.Kind
extension Log {
    
    public enum Kind {
        
        case print
        case api(data: SkyResponseData?)
        case system
        case error(Error?)
        case warning
        
        var index: Int {
            return Kind.allCases.firstIndex(of: self) ?? 0
        }
        
        var emoji: Character {
            switch self {
            case .print:
                return "⚪"
            case .api:
                return "🟢"
            case .system:
                return "🔵"
            case .error:
                return "🔴"
            case .warning:
                return "🟡"
            }
        }
        
        var emojiString: String {
            return String(emoji)
        }
        
        var color: UIColor {
            switch self {
            case .print:
                return .skyTextWhite
            case .api:
                return .skyGreen
            case .system:
                return .skyBlue
            case .error:
                return .skyRed
            case .warning:
                return .skyYellow
            }
        }
        
        var title: String {
            switch self {
            case .print:
                return "Print"
            case .api:
                return "Api"
            case .system:
                return "System"
            case .error:
                return "Error"
            case .warning:
                return "Warning"
            }
        }
        
    }
    
    public class Parameter {
        let key: String
        let value: CustomStringConvertible?
        
        public init(key: String, value: CustomStringConvertible?) {
            self.key = key
            self.value = value
        }
    }
    
}

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
    
}

//MARK: - Enums And Classes
extension Log {
    
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
        
        @available(iOS 13.0, *)
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
            result.append(SkyStringHandler.getTabSpace(repeatCount: 1, showDivider: true))
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

extension Log.Kind: CaseIterable, Equatable {
    
    public static var allCases: [Log.Kind] {
        return [.print, .api(data: nil), .system, .error(nil), .warning]
    }
    
    static var allCasesForCollectionView: [(title: String, emoji: Character?)] {
        var result: [(title: String, emoji: Character?)] = allCases.map({ (title: $0.title, emoji: $0.emoji) })
        result.append((title: "Custom", emoji: "🟣"))
        result.insert((title: "All", emoji: nil), at: 0)
        return result
    }
    
    public static func == (lhs: Log.Kind, rhs: Log.Kind) -> Bool {
        switch lhs {
        case .print:
            switch rhs {
            case .print:
                return true
            default:
                return false
            }
        case .api:
            switch rhs {
            case .api:
                return true
            default:
                return false
            }
        case .system:
            switch rhs {
            case .system:
                return true
            default:
                return false
            }
        case .error:
            switch rhs {
            case .error:
                return true
            default:
                return false
            }
        case .warning:
            switch rhs {
            case .warning:
                return true
            default:
                return false
            }
        }
    }
    
}

