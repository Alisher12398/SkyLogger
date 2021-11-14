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
        Logger by Alisher Khalykbayev

        Date: \(calendar.component(.day, from: date)).\(calendar.component(.month, from: date))
        
        App Version: \(appVersion)

        Device
            Name: \(UIDevice.current.getModelFromAll())
            Identifier: \(UIDevice.current.identifier)
            iOS Version: \(UIDevice.current.systemVersion)
            System Name: \(UIDevice.current.systemName)
            Location: \(TimeZone.current.identifier)
            Time Zone: \(TimeZone.current.abbreviation() ?? "null")

        Additional parameters:
        """
        additionalParameters.forEach({
            string.append("\n\($0.key): \($0.value ?? "")")
        })
        string.append("\n\n\n")
        return string
    }
    
    static func generateLogKindFirstLine(kind: Log.Kind) -> String {
        var result: String = ""
        let kindTitle: String = "\(kind.emoji) \(kind.rawValue)"
        result.append("􀄌 Logger: ")
        result.append(kindTitle)
        let date = Date()
        let calendar = Calendar.current
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
    
    static func convertLogsToString(logs: [Log]) -> String {
        var result: String = ""
        logs.forEach({
            result.append(convertLogToString(log: $0))
        })
        return result
    }
    
    static func convertLogToString(log: Log) -> String {
        var result: String = "\n\n"
        
        result.append(generateLogKindFirstLine(kind: log.kind))
        
        Log.LineKind.allCases.forEach({ item in
            result.append(item.formattedRawValue)
            let data: String = {
                switch item {
                    case .file:
                        let fileFiltered: String = String(log.file.split(separator: "/").last ?? "")
                        return getTabSpace(repeatCount: 2) + "| " + "\(fileFiltered); \(log.function): \(log.line)"
                        
                    case .message:
                        var dataResult: String = ""
                        let tabSpace = getTabSpace(repeatCount: 2) + "| "
                        if let message = log.parameters {
                            for value in message {
                                dataResult.append(tabSpace + "\(value.key): \(value.value ?? "nil")")
                            }
                        } else if let message = log.message {
                            if message.count == 1, let messageFirst = message.first {
                                dataResult.append(tabSpace + "\(messageFirst ?? "nil")")
                            } else if message.count > 1 {
                                for (index, value) in message.enumerated() {
                                    dataResult.append(tabSpace + "Paramater \(index): \(value ?? "nil")")
                                }
                            }
                        }
                        return dataResult
                }
            }()
            result.append(data)
        })
        return result
    }
    
    static func getTabSpace(repeatCount: Int, newLine: Bool = true) -> String {
        return (newLine ? "\n􀄌" : "") + String(repeating: "    ", count: repeatCount)
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


