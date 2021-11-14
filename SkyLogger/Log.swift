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
    
    public init(kind: Log.Kind, message: Any? = nil, parameters: Log.Parameter..., file: String = #file, _ function: String = #function, _ line: Int = #line) {
        self.kind = kind
        self.message = message
        self.parameters = parameters
        self.file = file
        self.function = function
        self.line = String(line)
    }
    
    public init(kind: Log.Kind, message: Any? = nil, parameters: [Log.Parameter]?, file: String = #file, _ function: String = #function, _ line: Int = #line) {
        self.kind = kind
        self.message = message
        self.parameters = parameters
        self.file = file
        self.function = function
        self.line = String(line)
    }
    
}

extension Log {
    
    public enum Kind {
        case print
        case api
        case system
        case error
        case warning
        
        var rawValue: String {
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
            }
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
                    return "Message"
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

