//
//  SkyStringHandler.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 15.11.2021.
//

import UIKit

public struct SkyStringHandler {
    
    static public func generateInfoHeaderString(additionalInfoParameters: [Log.Parameter] = []) -> String {
        let date = Date()
        let calendar = Calendar.current
        var string: String = """
        SkyLogger by Alisher Khalykbayev
        
        Date (dd.mm.yyyy): \(calendar.component(.day, from: date)).\(calendar.component(.month, from: date)).\(calendar.component(.year, from: date))
        
        App Version: \(Logger.singleton.appVersion)
        
        Device
            Name: \(UIDevice.current.getModelFromAll().rawValue)
            Identifier: \(UIDevice.current.identifier)
            iOS Version: \(UIDevice.current.systemVersion)
            System Name: \(UIDevice.current.systemName)
            Location: \(TimeZone.current.identifier)
            Time Zone: \(TimeZone.current.abbreviation() ?? "null")
        
        """
        if !additionalInfoParameters.isEmpty {
            string.append("Additional parameters:")
            additionalInfoParameters.forEach({
                string.append("\n\($0.key): \($0.value ?? "")")
            })
        }
        string.append("\n\n\n")
        return string
    }
    
    static public func generateLogKindFirstLine(kind: Log.Kind, customKey: Log.CustomKey?, date: Date, showDivider: Bool, destination: LogDetailDestination) -> String {
        var result: String = ""
        let kindTitle: String = "\(kind.emoji) \(kind.title)"
        switch destination {
        case .device:
            ()
        case .xcode:
            ()
        case .share:
            result.append("| SkyLogger: ")
        }
        if let customKey = customKey {
            result.append(customKey.emojiString + " " + customKey.title + " | ")
        }
        result.append(kindTitle)
        result.append(getTabSpace(repeatCount: 1, newLine: false, showDivider: showDivider))
        result.append(getDateString(date))
        return result
    }
    
    static func convertLogsToString(_ logs: [Log], showDivider: Bool, destination: SkyStringHandler.LogDetailDestination) -> String {
        var result: String = ""
        logs.forEach({
            result.append(convertLogToString($0, showDivider: showDivider, destination: destination))
        })
        return result
    }
    
    static public func convertLogToString(_ log: Log, showDivider: Bool, destination: SkyStringHandler.LogDetailDestination) -> String {
        var result: String = "\n"
        
        result.append(generateLogKindFirstLine(kind: log.kind, customKey: log.customKey, date: log.date, showDivider: showDivider, destination: destination))
        
        Log.LineKind.allCases.forEach({ item in
            result.append(item.getFormattedTitle(destination: destination))
            let data: String = {
                switch item {
                case .file:
                    return getLogFileLine(log: log, haveSpace: true, showDivider: showDivider)
                case .info:
                    return getLogInfoLine(log: log, showDivider: showDivider)
                }
            }()
            result.append(data)
        })
        result.append("\n")
        return result
    }
    
    static func getTabSpace(repeatCount: Int, newLine: Bool = true, showDivider: Bool) -> String {
        return (newLine ? (showDivider ? "\n|" : "\n") : "") + String(repeating: "    ", count: repeatCount)
    }
    
    static func getLogFileLine(log: Log, haveSpace: Bool, showDivider: Bool) -> String {
        let fileFiltered: String = String(log.file.split(separator: "/").last ?? "")
        let path: String = "\(fileFiltered); \(log.function): \(log.line)"
        if haveSpace {
            return getTabSpace(repeatCount: 2, showDivider: showDivider) + "  " + path
        } else {
            return path
        }
    }
    
    static private func getLogInfoLine(log: Log, showDivider: Bool) -> String {
        var dataResult: String = ""
        if let message = log.message {
            dataResult.append(getMessageLine(key: "Message", value: message, showDivider: showDivider))
        }
        
        if let parameters = log.parameters {
            for value in parameters {
                dataResult.append(getMessageLine(key: value.key, value: value.value, showDivider: showDivider))
            }
        }
        
        switch log.kind {
        case .api(data: let data):
            if let data = data {
                SkyLogger.SkyResponseData.Key.allCases.forEach({
                    dataResult.append(getMessageLine(key: $0.rawValue, value: $0.getValue(data: data), showDivider: showDivider))
                })
            }
            
        default:
            ()
        }
        
        return dataResult
    }
    
    static func getDateString(_ date: Date) -> String {
        let calendar = Calendar.current
        var result: String = ""
        result.append("[")
        result.append(calendar.component(.day, from: date))
        result.append(".")
        result.append(calendar.component(.month, from: date))
        result.append(" ")
        result.append(calendar.component(.hour, from: date))
        result.append(":")
        result.append(calendar.component(.minute, from: date))
        result.append("]")
        return result
    }
    
    private static func getMessageLine(key: String, value: Any?, showDivider: Bool) -> String {
        let tabSpace = getTabSpace(repeatCount: 2, showDivider: showDivider) + "  "
        return tabSpace + "\(key): \(value ?? "nil")"
    }
}

extension SkyStringHandler {
    
    public enum LogDetailDestination {
        case device
        case xcode
        case share
    }
    
}

fileprivate extension Calendar {
    
    func component(_ component: Calendar.Component, from date: Date) -> String {
        let valueInt: Int = self.component(component, from: date)
        switch component {
        case .month, .day, .hour, .minute, .second:
            var value: String = String(valueInt)
            if value.count == 1 { value.insert("0", at: value.startIndex) }
            return value
        default:
            return String(valueInt)
        }
    }
    
}

public extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) else { return nil }
        return prettyPrintedString
    }
}
