//
//  Logger.swift
//  OurMenu
//
//  Created by Alisher Khalykbayev on 07.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import UIKit

func log(kind: Log.Kind, message: Any?..., file: String = #file, _ function: String = #function, _ line: Int = #line) {
    Logger.log(kind: kind, message: message, parameters: nil, file: file, function: function, line: line)
}

func log(kind: Log.Kind, message: Log.Parameter..., file: String = #file, _ function: String = #function, _ line: Int = #line) {
    Logger.log(kind: kind, message: nil, parameters: message, file: file, function: function, line: line)
}

func log(kind: Log.Kind, parameters: [Log.Parameter], file: String = #file, _ function: String = #function, _ line: Int = #line) {
    Logger.log(kind: kind, message: nil, parameters: parameters, file: file, function: function, line: line)
}

fileprivate func getTabSpace(repeatCount: Int, newLine: Bool = true) -> String {
    return (newLine ? "\n􀄌" : "") + String(repeating: "    ", count: repeatCount)
}

class Logger: TextOutputStream {
    
    static let singleton: Logger = .init()
    private static let divider: String = "\n    􀄌 "
    
    private let fileName = "custom_logger.txt"
    
    private var fileURL: URL? {
        get {
            guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//                Toast.init(text: "Logger fileURL is nil", delay: 0, duration: 5).show()
                return nil
            }
            let fileURL = path.appendingPathComponent(fileName)
            return fileURL
        }
    }
}

//MARK:- Public Methods
extension Logger {
    
    func setup(appVersion: String) {
        removeFile()
        createFile()
    }
    
    fileprivate class func log(kind: Log.Kind, message: [Any?]?, parameters: [Log.Parameter]?, file: String, function: String, line: Int) {
        var result: String = "\n\n"
        
        result.append(generateLogKindFirstLine(kind: kind))
        
        LineKind.allCases.forEach({ item in
            result.append(item.formattedRawValue)
            let data: String = {
                switch item {
                    case .file:
                        let fileFiltered: String = String(file.split(separator: "/").last ?? "")
                        return getTabSpace(repeatCount: 2) + "| " + "\(fileFiltered); \(function): \(line)"
                        
                    case .message:
                        var dataResult: String = ""
                        let tabSpace = getTabSpace(repeatCount: 2) + "| "
                        if let message = parameters {
                            for value in message {
                                dataResult.append(tabSpace + "\(value.key): \(value.value ?? "nil")")
                            }
                        } else if let message = message {
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
        result.append("\n")
        print(result)
        Logger.singleton.write(result)
    }
    
    func write(_ string: String) {
        guard let fileURL = fileURL else { return }
        do {
            let data = string.data(using: String.Encoding.utf8)!
            try data.append(fileURL: fileURL)
        }
        catch {
//            Toast.init(text: "Logger write catch | error: \(error) | localizedDescription: \(error.localizedDescription) | string: \(string)", delay: 0, duration: 10).show()
        }
    }
    
    func share(vc: UIViewController, tintColor: UIColor) {
        insertInfoHeaderString()
        guard let fileURL = fileURL else {
            return
        }
        let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.view.tintColor = tintColor
        activityVC.popoverPresentationController?.sourceView = vc.view
        vc.navigationController?.present(activityVC, animated: true, completion: nil)
    }
    
}


//MARK:- Private Methods
private extension Logger {
    
    class func generateLogKindFirstLine(kind: Log.Kind) -> String {
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
    
    func createFile() {
        Logger.singleton.write("")
    }
    
    func removeFile() {
        guard let fileURL = fileURL else { return }
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("Logger. removeFile catch. Error: \(error). File: \(#file); function: \(#function)")
        }
    }
    
    func insertInfoHeaderString() {
        let date = Date()
        let calendar = Calendar.current
        
        let userId: Int = 0
        
        let userHashPartially: String = ""
        
        let userLogin: String = ""
        
        let separator: String = "\n\n\n"
        
        var string: String = """
        Logger by Alisher Khalykbayev
        Copyright © 2021 Alisher Khalykbayev. All rights reserved.

        Date: \(calendar.component(.day, from: date)).\(calendar.component(.month, from: date))
        
        App Version: ""

        Device
            Name: \(UIDevice.current.getModelFromAll())
            Identifier: \(UIDevice.current.identifier)
            iOS Version: \(UIDevice.current.systemVersion)
            System Name: \(UIDevice.current.systemName)
            Location: \(TimeZone.current.identifier)
            Time Zone: \(TimeZone.current.abbreviation() ?? "null")

        User:
            Id: \(userId)
            Hash partially: \(userHashPartially)
            Login: \(userLogin)
        \(separator)
        """
        
        let textFromFile: String = String(readFromFile().split(separator: " ").last ?? "")
        string.append(textFromFile)
        removeFile()
        
        Logger.singleton.write(string)
    }
    
    func readFromFile() -> String {
        guard let fileURL = fileURL else { return "" }
        do {
            let currentTextInFile: String = try String(contentsOf: fileURL, encoding: .utf8)
            return currentTextInFile
        } catch {
            return ""
        }
    }
    
}

//MARK:- Enums And Classes
extension Logger {
    
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
            return getTabSpace(repeatCount: 1) + firstSymbol + " " + self.rawValue
        }
    }
    
}

//MARK:- Data extension
fileprivate extension Data {
    
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
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

