//
//  ExampleViewController.swift
//  Example
//
//  Created by Алишер Халыкбаев on 06.09.2022.
//

import UIKit
import SkyLogger

class ExampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        Logger.setup(appVersion: "2.0", customization: .init())
        for _ in 0...5 {
            Logger.log(.init(kind: .print, message: "Test"))
            Logger.log(.init(kind: .print, message: "Message 1 Message 2 Message 3 Message 4 Message 5 Message 6 Message 7", parameters: [
                .init(key: "Key", value: "Value"),
                .init(key: "Key 1", value: "Value"),
                .init(key: "Key 2", value: "Value"),
                .init(key: "Key 3", value: "Value"),
                .init(key: "Key 4", value: "Value"),
            ]))
            Logger.log(.init(kind: .api(data: nil), message: "Test API"))
            
            Logger.log(.init(kind: .system, message: "Test message", parameters: .init(key: "Test parameter", value: "Test parameter value")))
            
            Logger.log(.init(kind: .print, message: 10))
            Logger.log(.init(kind: .print, message: 5.22))
            
            Logger.log(.init(kind: .analytics, message: Logger.convertObjectToString(TestClass(name: "Test name", value: 20))))
            
            Logger.log(.init(kind: .analytics, message: "Test analytics"))
            
            Logger.log(.init(kind: .analytics, message: nil))
            
            Logger.skyPrint("Test print message")
            skyPrint("Test print message 2")
            
            Logger.log(.init(kind: .print, message: "Test print customKey 1", customKey: .init(title: "CustomKey1")))
            
            log(.init(kind: .analytics, message: "Test print customKey 2", customKey: .init(title: "CustomKey2", emoji: "✈️")))
            
            let testClass = TestClass(name: "Test name", value: 10)
            
            print("Swift.print: \(testClass)")
            Logger.skyPrint(testClass)
            Logger.skyPrint(Logger.convertObjectToString(testClass))
            
            Logger.log(.init(kind: .error(NSError.init(domain: "domain", code: 10, userInfo: ["errorInfo1": "value"]))))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            Logger.log(.init(kind: .error(nil), message: "asyncAfter log"))
        })
        
        Logger.presentLogList(presentingViewController: navigationController)
    }
    
}

class TestClass {
    
    let name: String
    let value: Int
    
    init(name: String, value: Int) {
        self.name = name
        self.value = value
    }
    
}

