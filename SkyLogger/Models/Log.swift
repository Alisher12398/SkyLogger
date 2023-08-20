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
    let message: Any?
    let parameters: [Parameter]?
    let file: String
    let function: String
    let line: String
    let date: Date
    
    public convenience init(kind: Log.Kind, message: Any?, file: String = #file, function: String = #function, line: Int = #line) {
        self.init(logKind: kind, message: message, parameters: nil, file: file, function: function, line: line)
    }
    
    public convenience init(kind: Log.Kind, parameters: Log.Parameter..., file: String = #file, function: String = #function, line: Int = #line) {
        self.init(logKind: kind, message: nil, parameters: parameters, file: file, function: function, line: line)
    }
    
    public convenience init(kind: Log.Kind, parameters: [Log.Parameter], file: String = #file, function: String = #function, line: Int = #line) {
        self.init(logKind: kind, message: nil, parameters: parameters, file: file, function: function, line: line)
    }
    
    public convenience init(kind: Log.Kind, message: Any?, parameters: Log.Parameter..., file: String = #file, function: String = #function, line: Int = #line) {
        self.init(logKind: kind, message: message, parameters: parameters, file: file, function: function, line: line)
    }
    
    public convenience init(kind: Log.Kind, message: Any?, parameters: [Log.Parameter], file: String = #file, function: String = #function, line: Int = #line) {
        self.init(logKind: kind, message: message, parameters: parameters, file: file, function: function, line: line)
    }
    
    private init(logKind: Log.Kind, message: Any?, parameters: [Log.Parameter]?, file: String, function: String, line: Int) {
        self.kind = logKind
        self.message = message
        self.parameters = parameters
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
        case custom(key: String, emoji: String = "🟣")
        
        var index: Int {
            return Kind.allCases.firstIndex(of: self) ?? 0
        }
        
        var emoji: String {
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
            case .custom(key: _, emoji: let emoji):
                return emoji
            }
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
            case .custom:
                return .purple
            }
        }
        
        var title: String {
            switch self {
            case .print:
                return "Print"
            case .api:
                return "Api Response"
            case .system:
                return "System"
            case .error:
                return "Error"
            case .warning:
                return "Warning"
            case .custom(key: let key, emoji: _):
                return "Custom. Key: \(key)"
            }
        }
        
        var titleShort: String {
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
            case .custom:
                return "Custom"
            }
        }
        
    }
    
    public class Parameter {
        let key: String
        let value: Any?
        
        public init(key: String, value: Any?) {
            self.key = key
            self.value = value
        }
    }
    
}

//MARK: - Enums And Classes
extension Log {
    
    enum LineKind: CaseIterable {
        case file
        case info
        
        private var rawValue: String {
            switch self {
            case .file:
                return "File"
            case .info:
                return "Info"
            }
        }
        
        var formattedRawValue: String {
            let firstSymbol: String = {
                switch self {
                case .file:
                    return "📄" // 📄 iOS 14 􀫊
                case .info:
                    if #available(iOS 13, *) {
                        return "􀅴"
                    } else {
                        return "ℹ️"
                    }
                }
            }()
            return SkyStringHandler.getTabSpace(repeatCount: 1, showDivider: true) + firstSymbol + " " + self.rawValue
        }
    }
    
}

extension Log.Kind: CaseIterable, Equatable {
    
    public static var allCases: [Log.Kind] {
        return [.print, .api(data: nil), .system, .error(nil), .warning, .custom(key: "")]
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
        case .custom:
            switch rhs {
            case .custom:
                return true
            default:
                return false
            }
        }
    }
    
}

