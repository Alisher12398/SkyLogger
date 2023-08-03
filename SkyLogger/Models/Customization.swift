//
//  Customization.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

public class Customization {
    
    static var shared: Customization = .init(tintColor: .skyYellow)

    let tintColor: UIColor
    
    public init(tintColor: UIColor) {
        self.tintColor = tintColor
    }
    
}
