//
//  SkyCustomization.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

/**
 Class for future Logger customization.
 */
public class SkyCustomization {
    
    static var shared: SkyCustomization = .init()
    
    let newLogsOnTop: Bool
    
    /**
     Class for future Logger customization.
     */
    public init(newLogsOnTop: Bool = false) {
        self.newLogsOnTop = newLogsOnTop
    }
    
}
