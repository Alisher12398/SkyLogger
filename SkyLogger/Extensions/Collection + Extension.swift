//
//  Collection + Extension.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 18.11.2021.
//

import Foundation

extension Collection {

    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
