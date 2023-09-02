//
//  Logger.swift
//  OurMenu
//
//  Created by Alisher Khalykbayev on 07.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import UIKit

public func log(_ log: Log) {
    Logger.log(log)
}

public class Logger {
    
    public static var isEnabled: Bool = true
    
    static let singleton: Logger = .init()
    
    private var logs = SkyThreadSafeArray<Log>.init()
    
    var appVersion: String = "unknown"
    private var additionalInfoParameters: [Log.Parameter] = []
    
    private static let loggerPrintName: String = "SkyLogger. "
}

//MARK: - Public Methods
extension Logger {
    
    public static func setup(appVersion: String, customization: SkyCustomization = .init()) {
        Logger.singleton.appVersion = appVersion
        SkyCustomization.shared = customization
    }
    
    /**
     Add additional info about device, system, etc.
     
     - Parameters:
     - [Log.Parameter]. Array of additional parameters
     */
    public static func setAdditionalInfo(_ parameters: [Log.Parameter]) {
        Logger.singleton.additionalInfoParameters = parameters
    }
    
    /**
     Write a log.
     */
    public static func log(_ log: Log, file: String = #file, function: String = #function, line: Int = #line) {
        guard isEnabled else {
            Self.print(message: "log is not written because the Logger is disabled")
            return
        }
        Logger.singleton.logs.append(newElement: log)
        NotificationCenter.default.post(name: .newLogAdded, object: nil)
        Swift.print(SkyStringHandler.convertLogToString(log, showDivider: true, destination: .xcode))
    }
    
    /**
     Convenience func to show a log with .print kind only in Xcode
     */
    public static func skyPrint(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        guard let message = message as? CustomStringConvertible else {
            Swift.print(message)
            return
        }
        let log = Log.init(kind: .print, message: message, file: file, function: function, line: line)
        let string = SkyStringHandler.convertLogToString(log, showDivider: false, destination: .xcode)
        Swift.print(string)
    }
    
    /**
     Returns the URL for .txt file with logs.
     */
    public static func getTextFile() -> URL? {
        let result: URL? = SkyFileManager.shared.saveToTextFile(logs: Logger.singleton.logs.allCases, additionalInfoParameters: Logger.singleton.additionalInfoParameters)
        if let result = result {
            return result
        } else {
            Self.print(error: "can't convert logs to file for share")
            return nil
        }
    }
    
    /**
     Presents a list of logs. The present come in the passed UINavigationController.
     
     - Parameters:
     - Log.
     - UIViewController that will present UIActivityViewController. When nill it's found automatically.
     */
    public static func presentLogList(navigationController: UINavigationController?) {
        guard let navigationController = navigationController else {
            Self.print(error: "can't present Logger: passed UINavigationController is nil")
            return
        }
        let vc = LogListViewController()
        navigationController.present(SkyNavigationViewController(rootViewController: vc), animated: true, completion: nil)
    }
    
    /**
     Presents a modal popover `UIActivityViewController` to `Share` action that contains list of all logs. The present come in the passed UIViewController or in that is found automatically.
     
     - Parameters:
     - Log.
     - UIViewController that will present UIActivityViewController. When nill it's found automatically.
     */
    public static func shareLogList(presentingViewController: UIViewController? = nil) {
        guard let file = getTextFile(), let vc = presentingViewController ?? tryGetCurrentViewController() else {
            return
        }
        let activityVC = UIActivityViewController(activityItems: [file], applicationActivities: nil)
        activityVC.configure(viewController: vc)
        vc.present(activityVC, animated: true, completion: nil)
    }
    
    /**
     Presents a modal popover `UIActivityViewController` to `Share` action that contains the log. The present come in the passed UIViewController or in that is found automatically.
     
     - Parameters:
     - Log.
     - UIViewController that will present UIActivityViewController. When nill it's found automatically.
     */
    public static func shareLog(log: Log, presentingViewController: UIViewController? = nil) {
        guard let vc = presentingViewController ?? tryGetCurrentViewController() else { return }
        let data: String = SkyStringHandler.generateInfoHeaderString() + SkyStringHandler.convertLogToString(log, showDivider: false, destination: .share)
        let activityVC = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        activityVC.configure(viewController: vc)
        vc.present(activityVC, animated: true, completion: nil)
    }
    
    /**
     Creates a modal popover `UIActivityViewController` to `Share` action that contains the log.
     
     - Parameters:
     - Log.
     
     - Returns: popover `UIActivityViewController`.
     */
    public static func getLogShareViewController(log: Log) -> UIActivityViewController {
        let data: String = SkyStringHandler.convertLogToString(log, showDivider: false, destination: .share)
        let activityVC = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        activityVC.configure(viewController: nil)
        return activityVC
    }
    
    /**
     Creates a modal popover `UIActivityViewController` to `Share` action that contains list of all logs.
     
     - Returns: popover `UIActivityViewController` with list of all the logs.
     */
    public static func getLogListShareViewController() -> UIActivityViewController? {
        guard let file = getTextFile() else {
            return nil
        }
        let activityVC = UIActivityViewController(activityItems: [file], applicationActivities: nil)
        activityVC.configure(viewController: nil)
        return activityVC
    }
    
    /**
     Converts the class and struct object to String. But it is preferable to implement the `CustomStringConvertible` protocol.
     
     - Returns: String describing the object.
     */
    public static func convertObjectToString(_ object: Any) -> String {
        let mirror = Mirror(reflecting: object)
        var description = String(describing: mirror.subjectType) + ": "
        for (index, (label, value)) in mirror.children.enumerated() {
            if let label = label {
                if index > 0 {
                    description += ", "
                }
                description += "\(label): \(value)"
                if index == mirror.children.count - 1 {
                    description += ". "
                }
            }
        }
        return description
    }
    
}

//MARK: - Protected Methods
extension Logger {
    
    static func getLogs() -> [Log] {
        return Logger.singleton.logs.allCases
    }
    
    static func print(message: String) {
        Swift.print(loggerPrintName + "Message: " + message)
    }
    
    static func print(error: String) {
        Swift.print(loggerPrintName + "Error: " + error)
    }
    
}


//MARK: - Private Methods
private extension Logger {
    
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

fileprivate extension UIActivityViewController {
    
    func configure(viewController: UIViewController?) {
        self.modalPresentationStyle = .popover
        if let popoverController = self.popoverPresentationController, let viewController = viewController {
            popoverController.sourceView = viewController.view
        }
    }
    
}
