//
//  SkyNavigationViewController.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 03.08.2023.
//

import UIKit

class SkyNavigationViewController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
