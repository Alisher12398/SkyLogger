//
//  Customization.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

public class Customization {
    
    static var shared: Customization = .init(tintColor: .skyYellow, secondaryColor: .black)

    let tintColor: UIColor
    let secondaryColor: UIColor
    
    public init(tintColor: UIColor, secondaryColor: UIColor) {
        self.tintColor = tintColor
        self.secondaryColor = secondaryColor
    }
    
}
