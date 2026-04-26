//
//  SkyConfiguration.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

/**
 Class for future Logger configuration.
 */
public class SkyConfiguration {
    
    static private(set) var shared: SkyConfiguration = .init(sortType: .newOnTop, shakeToPresent: true)

    static func setShared(_ configuration: SkyConfiguration) {
        shared = configuration
    }

    private(set) var sortType: SortType
    private(set) var shakeToPresent: Bool

    /**
     Class for future Logger configuration.
     */
    public init(sortType: SortType, shakeToPresent: Bool) {
        self.sortType = sortType
        self.shakeToPresent = shakeToPresent
    }
    
    public func toggleSortType() {
        switch sortType {
        case .newOnTop:
            self.sortType = .newOnBottom
        case .newOnBottom:
            self.sortType = .newOnTop
        }
        NotificationCenter.default.post(name: .newLogAdded, object: nil)
    }
    
}

public extension SkyConfiguration {
    
    enum SortType {
        case newOnTop
        case newOnBottom
    }
    
}
