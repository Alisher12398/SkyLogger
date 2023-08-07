//
//  Customization.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

public class Customization {
    
    static var shared: Customization = .init(tableViewAutomaticDimension: false)
    
    /// При `true` ячейка лога  в списке более подробная и вычисляется автоматически. Улучшает список визуально. По дефолту `true`
    ///
    let tableViewAutomaticDimension: Bool
    
    /**
     Создание кастомизации для SkyLogger.
     
     - Parameters:
     - tableViewAutomaticDimension: При `true` ячейка лога  в списке более подробная и вычисляется автоматически. Улучшает список визуально. По дефолту `true`
     */
    
    public init(tableViewAutomaticDimension: Bool = true) {
        self.tableViewAutomaticDimension = tableViewAutomaticDimension
    }
    
}
