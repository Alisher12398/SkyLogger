//
//  Logger.swift
//  OurMenu
//
//  Created by Alisher Khalykbayev on 07.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import UIKit

//func log(kind: Log.Kind, message: Any?..., file: String = #file, _ function: String = #function, _ line: Int = #line) {
//    Logger.log(kind: kind, message: message, parameters: nil, file: file, function: function, line: line)
//}
//
//func log(kind: Log.Kind, message: Log.Parameter..., file: String = #file, _ function: String = #function, _ line: Int = #line) {
//    Logger.log(kind: kind, message: nil, parameters: message, file: file, function: function, line: line)
//}
//
//func log(kind: Log.Kind, parameters: [Log.Parameter], file: String = #file, _ function: String = #function, _ line: Int = #line) {
//    Logger.log(kind: kind, message: nil, parameters: parameters, file: file, function: function, line: line)
//}

public class Logger {
    
    private static let singleton: Logger = .init()
    private static let divider: String = "\n    | "
    
    private var logs: [Log] = []
    
    private var appVersion: String = "unknown"
    private var additionalParameters: [Log.Parameter] = []
    
    static func print(_ text: String, file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Swift.print("SkyLogger Print. File: \(file); Function: \(function); Line: \(line); text: \(text)")
    }
}

//MARK:- Public Methods
extension Logger {
    
    public static func setup(appVersion: String) {
        Logger.singleton.appVersion = appVersion
    }
    
    public static func setAdditionalParameters(_ parameters: [Log.Parameter]) {
        Logger.singleton.additionalParameters = parameters
    }
    
    public static func log(_ log: Log, file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Logger.singleton.logs.append(log)
        Swift.print(StringHandler.convertLogToString(log))
    }
    
    public static func share(vc: UIViewController, tintColor: UIColor) {
        guard let url = FileManager.shared.saveToTextFile(logs: Logger.singleton.logs, appVersion: Logger.singleton.appVersion, additionalParameters: Logger.singleton.additionalParameters) else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.view.tintColor = tintColor
        activityVC.popoverPresentationController?.sourceView = vc.view
        vc.navigationController?.present(activityVC, animated: true, completion: nil)
    }
    
}


//MARK:- Private Methods
private extension Logger {
    
}
