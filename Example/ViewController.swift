//
//  ViewController.swift
//  Example
//
//  Created by Алишер Халыкбаев on 06.09.2022.
//

import UIKit
import SkyLogger

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray

        Logger.log(.init(kind: .print, message: "Test"))
    }

}

