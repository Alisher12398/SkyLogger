//
//  Customization.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

public class Customization {
    
    static var shared: Customization = .init(tintColor: .blue, secondaryColor: .black, backgroundColor: .white)

    let tintColor: UIColor
    let secondaryColor: UIColor
    let backgroundColor: UIColor
    
    public init(tintColor: UIColor, secondaryColor: UIColor, backgroundColor: UIColor) {
        self.tintColor = tintColor
        self.secondaryColor = secondaryColor
        self.backgroundColor = backgroundColor
    }
    
}
