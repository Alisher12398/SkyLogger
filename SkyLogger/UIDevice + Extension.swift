//
//  UIDevice + Extension.swift
//  OurMenu
//
//  Created by Alisher Khalykbayev on 08.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import UIKit

extension UIDevice {
    
    func getModelFromAll() -> Device.AllModels {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> Device.AllModels {
            switch identifier {
            case "iPhone5,1", "iPhone5,2": return .iPhone(kind: ._5)
            case "iPhone5,3", "iPhone5,4": return .iPhone(kind: ._5C)
            case "iPhone6,1", "iPhone6,2": return .iPhone(kind: ._5S)
            case "iPhone7,2": return .iPhone(kind: ._6)
            case "iPhone7,1": return .iPhone(kind: ._6_PLUS)
            case "iPhone8,1": return .iPhone(kind: ._6S)
            case "iPhone8,2": return .iPhone(kind: ._6s_PLUS)
            case "iPhone9,1", "iPhone9,3": return .iPhone(kind: ._7)
            case "iPhone9,2", "iPhone9,4": return .iPhone(kind: ._7_PLUS)
            case "iPhone8,4": return .iPhone(kind: ._SE)
            case "iPhone10,1", "iPhone10,4": return .iPhone(kind: ._8)
            case "iPhone10,2", "iPhone10,5": return .iPhone(kind: ._8_PLUS)
            case "iPhone10,3", "iPhone10,6": return .iPhone(kind: ._X)
            case "iPhone11,2": return .iPhone(kind: ._XS)
            case "iPhone11,4", "iPhone11,6": return .iPhone(kind: ._XS_MAX)
            case "iPhone11,8": return .iPhone(kind: ._XR)
            case "iPhone12,1": return .iPhone(kind: ._11)
            case "iPhone12,3": return .iPhone(kind: ._11_PRO)
            case "iPhone12,5": return .iPhone(kind: ._11_PRO_MAX)
            case "iPhone12,8": return .iPhone(kind: ._SE_2)
                
            case "iPhone13,1": return .iPhone(kind: ._12_MINI)
            case "iPhone13,2": return .iPhone(kind: ._12)
            case "iPhone13,3": return .iPhone(kind: ._12_PRO)
            case "iPhone13,4": return .iPhone(kind: ._12_PRO_MAX)
                
            case "iPhone14,2": return .iPhone(kind: ._13)
            case "iPhone14,3": return .iPhone(kind: ._13_mini)
            case "iPhone14,4": return .iPhone(kind: ._13_pro)
            case "iPhone14,5": return .iPhone(kind: ._13_pro_max)
                
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad_OLD
            case "iPad3,1", "iPad3,2", "iPad3,3": return .iPad_OLD
            case "iPad3,4", "iPad3,5", "iPad3,6": return .iPad_OLD
            case "iPad6,11", "iPad6,12": return .iPad_NEW
            case "iPad7,5", "iPad7,6": return .iPad_NEW
            case "iPad7,11", "iPad7,12": return .iPad_NEW
            case "iPad4,1", "iPad4,2", "iPad4,3": return .iPad_OLD
            case "iPad5,3", "iPad5,4": return .iPad_OLD
            case "iPad11,4", "iPad11,5": return .iPad_NEW
            case "iPad2,5", "iPad2,6", "iPad2,7": return .iPad_OLD
            case "iPad4,4", "iPad4,5", "iPad4,6": return .iPad_OLD
            case "iPad4,7", "iPad4,8", "iPad4,9": return .iPad_OLD
            case "iPad5,1", "iPad5,2": return .iPad_NEW
            case "iPad11,1", "iPad11,2": return .iPad_NEW
            case "iPad6,3", "iPad6,4": return .iPad_NEW
            case "iPad6,7", "iPad6,8": return .iPad_NEW
            case "iPad7,1", "iPad7,2": return .iPad_NEW
            case "iPad7,3", "iPad7,4": return .iPad_NEW
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return .iPad_NEW
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return .iPad_NEW
                
            case "i386", "x86_64": return .simulator
            default: return .unknown
            }
        }
        
        return mapToDevice(identifier: identifier)
    }
    
    enum ModelsByScreenSize {
        case iPhone_5
        case iPhone_6
        case iPhone_6plus
        case iPhone_XR_11
        case iPhone_X_XS_11Pro
        case iPhone_XSMax_11ProMax
        case unknown
    }
    
    var identifier: String {
        get {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            return identifier
        }
    }
    
    func getModelByScreenSize() -> Device.ModelsByScreenSize {
        switch self.getModelFromAll() {
        case .iPhone(kind: ._5), .iPhone(kind: ._5C), .iPhone(kind: ._5S), .iPhone(kind: ._SE):
            return .iPhone_5
        case .iPhone(kind: ._6), .iPhone(kind: ._6S), .iPhone(kind: ._7), .iPhone(kind: ._8), .iPhone(kind: ._SE_2), .iPhone(kind: ._12_MINI):
            return .iPhone_6
        case .iPhone(kind: ._6_PLUS), .iPhone(kind: ._6s_PLUS), .iPhone(kind: ._7_PLUS), .iPhone(kind: ._8_PLUS):
            return .iPhone_Plus
        case .iPhone(kind: ._XR), .iPhone(kind: ._11), .iPhone(kind: ._12):
            return .iPhone_XR
        case .iPhone(kind: ._X), .iPhone(kind: ._XS), .iPhone(kind: ._11_PRO), .iPhone(kind: ._12_PRO):
            return .iPhone_X
        case .iPhone(kind: ._XS_MAX), .iPhone(kind: ._11_PRO_MAX), .iPhone(kind: ._12_PRO_MAX):
            return .iPhone_Max
        default:
            return .unknown
        }
    }
    
    func isHaveHomeIndicator() -> Bool {
        switch self.getModelByScreenSize() {
        case .iPhone_5, .iPhone_6, .unknown, .iPhone_Plus:
            return false
        case .iPhone_X, .iPhone_XR, .iPhone_Max:
            return true
        }
    }
    
    func getModelSize() -> Device.ScreenSize {
        switch self.getModelByScreenSize() {
        case .iPhone_5:
            return .small
        case .iPhone_6, .unknown:
            return .medium
        case .iPhone_X, .iPhone_XR, .iPhone_Plus:
            return .large
        case .iPhone_Max:
            return .veryLarge
        }
    }
    
}
