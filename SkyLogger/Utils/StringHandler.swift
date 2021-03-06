//
//  StringHandler.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 15.11.2021.
//

import UIKit

struct StringHandler {
    
    static func generateInfoHeaderString(appVersion: String, additionalParameters: [Log.Parameter]) -> String {
        let date = Date()
        let calendar = Calendar.current
        var string: String = """
        SkyLogger by Alisher Khalykbayev
        
        Date: \(calendar.component(.day, from: date)).\(calendar.component(.month, from: date))
        
        App Version: \(appVersion)
        
        Device
            Name: \(UIDevice.current.getModelFromAll())
            Identifier: \(UIDevice.current.identifier)
            iOS Version: \(UIDevice.current.systemVersion)
            System Name: \(UIDevice.current.systemName)
            Location: \(TimeZone.current.identifier)
            Time Zone: \(TimeZone.current.abbreviation() ?? "null")
        
        """
        if !additionalParameters.isEmpty {
            string.append("Additional parameters:")
            additionalParameters.forEach({
                string.append("\n\($0.key): \($0.value ?? "")")
            })
        }
        string.append("\n\n\n")
        return string
    }
    
    static func generateLogKindFirstLine(kind: Log.Kind, date: Date) -> String {
        var result: String = ""
        let kindTitle: String = "\(kind.emoji) \(kind.title)"
        result.append("| SkyLogger: ")
        result.append(kindTitle)
        result.append(getDateString(date))
        return result
    }
    
    static func convertLogsToString(_ logs: [Log]) -> String {
        var result: String = ""
        logs.forEach({
            result.append(convertLogToString($0))
        })
        return result
    }
    
    static func convertLogToString(_ log: Log) -> String {
        var result: String = "\n"
        
        result.append(generateLogKindFirstLine(kind: log.kind, date: log.date))
        
        Log.LineKind.allCases.forEach({ item in
            result.append(item.formattedRawValue)
            let data: String = {
                switch item {
                case .file:
                    return getFileLine(log: log, haveSpace: true)
                    
                case .message:
                    var dataResult: String = ""
                    if let message = log.message {
                        dataResult.append(getMessageLine(key: "Message", value: message))
                    }
                    
                    if let parameters = log.parameters {
                        for value in parameters {
                            dataResult.append(getMessageLine(key: value.key, value: value.value))
                        }
                    }
                    
                    switch log.kind {
                    case .api(data: let data):
                        SkyLogger.ResponseData.Key.allCases.forEach({
                            dataResult.append(getMessageLine(key: $0.rawValue, value: $0.getValue(data: data)))
                        })
                    default:
                        ()
                    }
                    
                    return dataResult
                }
            }()
            result.append(data)
        })
        result.append("\n")
        return result
    }
    
    static func getTabSpace(repeatCount: Int, newLine: Bool = true) -> String {
        return (newLine ? "\n|" : "") + String(repeating: "    ", count: repeatCount)
    }
    
    static func getFileLine(log: Log, haveSpace: Bool) -> String {
        let fileFiltered: String = String(log.file.split(separator: "/").last ?? "")
        let path: String = "\(fileFiltered); \(log.function): \(log.line)"
        if haveSpace {
            return getTabSpace(repeatCount: 2) + "  " + path
        } else {
            return path
        }
    }
    
    static func getDateString(_ date: Date) -> String {
        let calendar = Calendar.current
        var result: String = ""
        result.append(getTabSpace(repeatCount: 1, newLine: false))
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
    
    private static func getMessageLine(key: String, value: Any?) -> String {
        let tabSpace = getTabSpace(repeatCount: 2) + "  "
        return tabSpace + "\(key): \(value ?? "nil")"
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
