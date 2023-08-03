//
//  UINavigationBar + Extension.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 06.09.2022.
//

import UIKit

extension UINavigationBar {
    
    func configure() {
        tintColor = UIColor.skyTextWhite
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = false
        barTintColor = UIColor.skyBackground
        backgroundColor = UIColor.skyBackground
        superview?.backgroundColor = UIColor.skyBackground
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.skyTextWhite]
        titleTextAttributes = textAttributes
    }
    
}
