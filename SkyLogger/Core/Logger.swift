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
    
    private var logs = SkyThreadSafeArray<Log>.init()
    
    private var appVersion: String = "unknown"
    private var additionalParameters: [Log.Parameter] = []
    
    private static let loggerPrintName: String = "SkyLogger"
    
    static func print(_ text: String, file: String = #file, _ function: String = #function, _ line: Int = #line) {
        Swift.print("SkyLogger Print. File: \(file); Function: \(function); Line: \(line); text: \(text)")
    }
}

//MARK: - Public Methods
extension Logger {
    
    public static func setup(appVersion: String, customization: SkyCustomization) {
        Logger.singleton.appVersion = appVersion
        SkyCustomization.shared = customization
    }
    
    public static func setAdditionalParameters(_ parameters: [Log.Parameter]) {
        Logger.singleton.additionalParameters = parameters
    }
    
    public static func log(_ log: Log, file: String = #file, function: String = #function, line: Int = #line) {
        guard isEnabled else {
            Self.print("log is not written because the logger is disabled")
            return
        }
        Logger.singleton.logs.append(newElement: log)
        Swift.print(SkyStringHandler.convertLogToString(log, showDivider: true))
    }
    
    public static func getTextFile() -> URL? {
        let result: URL? = SkyFileManager.shared.saveToTextFile(logs: Logger.singleton.logs.allCases, appVersion: Logger.singleton.appVersion, additionalParameters: Logger.singleton.additionalParameters)
        if let result = result {
            return result
        } else {
            Self.print(error: "can't convert logs to file for share")
            return nil
        }
    }
    
    public static func convertLogsToString() -> String {
        return SkyStringHandler.convertLogsToString(Logger.singleton.logs.allCases, showDivider: true)
    }
    
    public static func shareLogs(vc: UIViewController?) {
        guard let file = getTextFile(), let vc = vc ?? tryGetCurrentViewController() else {
            return
        }
        let activityVC = makeShareViewController(activityItems: [file])
        vc.present(activityVC, animated: true, completion: nil)
    }
    
    public static func present(nc: UINavigationController?) {
        let vc = LogListViewController()
        nc?.present(SkyNavigationViewController(rootViewController: vc), animated: true, completion: nil)
    }
    
    public static func shareLog(log: Log, vc: UIViewController?) {
        guard let vc = vc ?? tryGetCurrentViewController() else { return }
        let activityVC = makeShareViewController(activityItems: [SkyStringHandler.convertLogToString(log, showDivider: false)])
        vc.present(activityVC, animated: true, completion: nil)
    }
    
    public static func getLogShareVC(log: Log) -> UIActivityViewController {
        let activityVC = makeShareViewController(activityItems: [SkyStringHandler.convertLogToString(log, showDivider: false)])
        return activityVC
    }
    
    public static func getLogsShareVC() -> UIActivityViewController? {
        guard let file = getTextFile() else {
            return nil
        }
        let activityVC = makeShareViewController(activityItems: [file])
        return activityVC
    }
    
}

//MARK: - Protected Methods
extension Logger {
    
    static func getLogs() -> [Log] {
        return Logger.singleton.logs.allCases
    }
    
    static func print(message: String) {
        Swift.print(loggerPrintName + "message: " + message)
    }
    
    static func print(error: String) {
        Swift.print(loggerPrintName + "error: " + error)
    }
    
}


//MARK: - Private Methods
private extension Logger {
    
    private static func makeShareViewController(activityItems: [Any]) -> UIActivityViewController {
        let activityVC = UIActivityViewController(activityItems: [activityItems], applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        return activityVC
    }
    
    private static func tryGetCurrentViewController() -> UIViewController? {
        let currentWindow = UIApplication.shared.windows.first
        let error = "can't find current visible UIViewController to share"
        if #available(iOS 15, *) {
            if let currentScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
            {
                if let visibleViewController = currentScene.visibleViewController {
                    return visibleViewController
                } else if let visibleViewController = tryGetFromAppDelegate() {
                    return visibleViewController
                } else {
                    Self.print(error: error)
                    return nil
                }
                
            } else {
                return tryGetFromAppDelegate()
            }
        } else {
            return tryGetFromAppDelegate()
        }
        
        func tryGetFromAppDelegate() -> UIViewController? {
            if let visibleViewController =  currentWindow?.visibleViewController {
                return visibleViewController
            } else {
                Self.print(error: error)
                return nil
            }
        }
    }
    
}
