//
//  Log.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 08.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import Foundation

public class Log {
    
    let kind: Kind
    let message: Any?
    let parameters: [Parameter]?
    let file: String
    let function: String
    let line: String
    let date: Date
    
    public init(kind: Log.Kind, message: Any? = nil, parameters: Log.Parameter..., file: String = #file, function: String = #function, _ line: Int = #line) {
        self.kind = kind
        self.message = message
        self.parameters = parameters
        self.file = file
        self.function = function
        self.line = String(line)
        self.date = Date()
    }
    
    public init(kind: Log.Kind, message: Any? = nil, parameters: [Log.Parameter]? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        self.kind = kind
        self.message = message
        self.parameters = parameters
        self.file = file
        self.function = function
        self.line = String(line)
        self.date = Date()
    }
    
}

extension Log {
    
    public enum Kind: CaseIterable, Equatable {
        
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
        
        public static var allCases: [Log.Kind] = [.print, .api(data: .init()), .system, .error, .warning, .custom(key: "")]
        
        case print
        case api(data: ResponseData)
        case system
        case error
        case warning
        case custom(key: String, emoji: String = "⚪")
        
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
            case .custom(key: let key):
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

//MARK:- Enums And Classes
extension Log {
    
    enum LineKind: CaseIterable {
        case file
        case message
        
        private var rawValue: String {
            switch self {
            case .file:
                return "File"
            case .message:
                return "Info"
            }
        }
        
        var formattedRawValue: String {
            let firstSymbol: String = {
                switch self {
                case .file:
                    return "📝"
                case .message:
                    return "ℹ️"
                }
            }()
            return StringHandler.getTabSpace(repeatCount: 1) + firstSymbol + " " + self.rawValue
        }
    }
    
}

