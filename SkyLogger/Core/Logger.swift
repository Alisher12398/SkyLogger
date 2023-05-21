//
//  Logger.swift
//  OurMenu
//
//  Created by Alisher Khalykbayev on 07.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import UIKit

public class Logger {
    
    public static var isEnabled: Bool = true
    
    private static let singleton: Logger = .init()
    private static let divider: String = "\n    | "
    
    private var logs = ThreadSafeArray<Log>.init()
    
    private var appVersion: String = "unknown"
    private var additionalParameters: [Log.Parameter] = []
    
    static func print(_ text: String, file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Swift.print("SkyLogger Print. File: \(file); Function: \(function); Line: \(line); text: \(text)")
    }
}

//MARK:- Public Methods
extension Logger {
    
    public static func setup(appVersion: String, customization: Customization) {
        Logger.singleton.appVersion = appVersion
        Customization.shared = customization
    }
    
    public static func setAdditionalParameters(_ parameters: [Log.Parameter]) {
        Logger.singleton.additionalParameters = parameters
    }
    
    public static func log(_ log: Log, file: String = #file, function: String = #function, line: Int = #line) {
        guard isEnabled else {
            Swift.print("!! SkyLogger is disabled")
            return
        }
        Logger.singleton.logs.append(newElement: log)
        Swift.print(SkyStringHandler.convertLogToString(log))
    }
    
    public static func getTextFile() -> URL? {
        return FileManager.shared.saveToTextFile(logs: Logger.singleton.logs.allCases, appVersion: Logger.singleton.appVersion, additionalParameters: Logger.singleton.additionalParameters)
    }
    
    public static func convertLogsToString() -> String {
        return SkyStringHandler.convertLogsToString(Logger.singleton.logs.allCases)
    }
    
    public static func share(vc: UIViewController, tintColor: UIColor) {
        guard let url = getTextFile() else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.view.tintColor = tintColor
        activityVC.popoverPresentationController?.sourceView = vc.view
        vc.navigationController?.present(activityVC, animated: true, completion: nil)
    }
    
    public static func push(nc: UINavigationController?) {
        let vc = LogListViewController()
        nc?.pushViewController(vc, animated: true)
    }
    
    public static func present(nc: UINavigationController?) {
        let vc = LogListViewController()
        nc?.present(generateNavigationController(rootVC: vc), animated: true, completion: nil)
    }
    
    public static func generateNavigationController(rootVC: UIViewController) -> UINavigationController {
        let nc = UINavigationController(rootViewController: rootVC)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.backgroundLight]
        nc.navigationBar.titleTextAttributes = textAttributes
        nc.navigationBar.configure()
        return nc
    }
    
    static func getLogs() -> [Log] {
        return Logger.singleton.logs.allCases
    }
    
}


//MARK:- Private Methods
private extension Logger {
    
}
