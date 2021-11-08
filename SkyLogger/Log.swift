//
//  Log.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 08.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import Foundation

class Log {
    
    let kind: Kind
    let additionalParameters: [Parameter]
    
    internal init(kind: Log.Kind, additionalParameters: [Log.Parameter]) {
        self.kind = kind
        self.additionalParameters = additionalParameters
    }
    
}

extension Log {
    
    enum Kind {
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
    
    class Parameter {
        let key: String
        let value: Any?
        
        internal init(key: String, value: Any?) {
            self.key = key
            self.value = value
        }
    }
    
}
