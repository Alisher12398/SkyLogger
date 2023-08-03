//
//  ViewController.swift
//  Example
//
//  Created by Алишер Халыкбаев on 06.09.2022.
//

import UIKit
import SkyLogger

class TeeeeeeeeeeestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        Logger.log(.init(kind: .print, message: "Test"))
        Logger.log(.init(kind: .print, message: "ViewController ViewController ViewController ViewController ViewController ViewController ViewController ViewController ViewController", parameters: [
            .init(key: "ViewController Key", value: "ViewController Value"),
            .init(key: "ViewController Key 1", value: "ViewController Value"),
            .init(key: "ViewController Key 2", value: "ViewController Value"),
            .init(key: "ViewController Key 3", value: "ViewController Value"),
            .init(key: "ViewController Key 4", value: "ViewController Value"),
        ]))
        Logger.log(.init(kind: .api(data: nil), message: "Test2"))
        
        Logger.log(.init(kind: .system, message: "Test2"))
        
        Logger.log(.init(kind: .warning, message: "Test2"))
        
        Logger.log(.init(kind: .warning, message: nil))
        
        Logger.log(.init(kind: .custom(key: "Test key"), message: "Test2"))
        
        Logger.log(.init(kind: .error(nil), message: "Test2"))
        Logger.present(nc: navigationController)
    }

}

