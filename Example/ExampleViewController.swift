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
        Logger.setup(appVersion: "2.0", customization: .init(sortType: .newOnTop))
        
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
            
            Logger.log(.init(kind: .system, message: "Test message", parameters: [.init(key: "Test parameter", value: "Test parameter value")]))
            
            Logger.log(.init(kind: .print, message: 10))
            Logger.log(.init(kind: .print, message: 5.22))
            
            Logger.log(.init(kind: .analytics, message: "Test analytics"))
            
            Logger.log(.init(kind: .analytics, message: nil))
            
            Logger.skyPrint("Test print message")
            Logger.skyPrint("Test print message 2")
            
            Logger.log(.init(kind: .print, message: "Test print customKey 1", customKey: .init(title: "CustomKey1")))
            
            log(.init(kind: .analytics, message: "Test print customKey 2", customKey: .init(title: "CustomKey2", emoji: "✈️")))
            
            Logger.log(kind: .print, parameters: .init(key: "test", value: "test value"))
            
            let testClass1 = TestClass(name: "Test name 1", value: 10)
            let testClass2 = TestClass(name: "Test name 2", value: 20)
            let testClass3 = TestClass(name: "Test name 3", value: 30)
            let testClass4 = TestClass(name: "Test name 4", value: 100)
            
            let testClassArray: [TestClass] = [
                testClass1, testClass2, testClass3, testClass4
            ]
            let testClassSet: Set<TestClass> = [
                testClass1, testClass2, testClass3, testClass4
            ]
            let testClassDictionaty1: [TestClass: Int] = [
                testClass1: 1,
                testClass2: 2,
                testClass3: 3,
                testClass4: 4
            ]
            let testClassDictionaty2: [Int: TestClass] = [
                1: testClass1,
                2: testClass2,
                3: testClass3,
                4: testClass4
            ]
            
            print("Swift.print: \(testClass1)")
            Logger.skyPrint(testClass1)
            Logger.skyPrint(testClassArray)
            Logger.skyPrint(testClassSet)
            Logger.skyPrint(testClassDictionaty1)
            Logger.skyPrint(testClassDictionaty2)
            
            Logger.log(kind: .print, message: testClass1)
            Logger.log(kind: .print, message: testClass2)
            Logger.log(kind: .print, message: testClassArray)
            Logger.log(kind: .print, message: testClassSet)
            Logger.log(kind: .print, message: testClassDictionaty1)
            Logger.log(kind: .print, message: testClassDictionaty2)
            
            Logger.log(kind: .print, parameters: [
                .init(key: "TestClass Array", value: testClassArray)
            ])
            Logger.log(kind: .print, parameters: [
                .init(key: "TestClass Set", value: testClassSet)
            ])
            Logger.log(kind: .print, parameters: [
                .init(key: "TestClass Dictionary 1", value: testClassDictionaty1)
            ])
            Logger.log(kind: .print, parameters: [
                .init(key: "TestClass Dictionary 2", value: testClassDictionaty2)
            ])
            
            Logger.log(.init(kind: .error(NSError.init(domain: "domain", code: 10, userInfo: ["errorInfo1": "value"]))))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
            Logger.log(.init(kind: .error(nil), message: "asyncAfter log"))
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0, execute: {
            Logger.log(.init(kind: .error(nil), message: "asyncAfter log"))
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 20.0, execute: {
            Logger.log(.init(kind: .error(nil), message: "asyncAfter log"))
        })
        
        Logger.presentLogList(presentingViewController: navigationController)
    }
    
}

class TestClass: Hashable {
    
    static func == (lhs: TestClass, rhs: TestClass) -> Bool {
        return (lhs.name == rhs.name && lhs.value == rhs.value)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(value)
    }
    
    let name: String
    let value: Int
    
    init(name: String, value: Int) {
        self.name = name
        self.value = value
    }
    
}

