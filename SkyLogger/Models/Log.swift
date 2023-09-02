//
//  Log.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 08.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import UIKit

public class Log: Equatable {
    
    public static func == (lhs: Log, rhs: Log) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
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
        self.id = Self.makeRandomString(length: 15)
        self.kind = logKind
        self.message = message
        self.parameters = parameters
        self.customKey = customKey
        self.file = file
        self.function = function
        self.line = String(line)
        self.date = Date()
    }
    
    private static func makeRandomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        
        for _ in 0..<length {
            if let randomChar = letters.randomElement() {
                randomString.append(randomChar)
            }
        }
        
        return randomString
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



