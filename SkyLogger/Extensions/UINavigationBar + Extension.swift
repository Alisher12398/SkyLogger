//
//  UINavigationBar + Extension.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 06.09.2022.
//

import UIKit

extension UINavigationBar {
    
    func configure() {
        tintColor = UIColor.backgroundLight
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = false
        barTintColor = UIColor.background
        backgroundColor = UIColor.background
        superview?.backgroundColor = UIColor.background
    }
    
}
