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
    
    static var shared: SkyCustomization = .init(sortType: .newOnTop)
    
    private(set) var sortType: SortType
    
    /**
     Class for future Logger customization.
     */
    public init(sortType: SortType) {
        self.sortType = sortType
    }
    
    func toogleSortType() {
        switch sortType {
        case .newOnTop:
            self.sortType = .newOnBottom
        case .newOnBottom:
            self.sortType = .newOnTop
        }
        NotificationCenter.default.post(name: .newLogAdded, object: nil)
    }
    
}

public extension SkyCustomization {
    
    enum SortType {
        case newOnTop
        case newOnBottom
    }
    
}
