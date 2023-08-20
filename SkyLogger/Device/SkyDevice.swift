//
//  SkyDevice.swift
//  OurMenu
//
//  Created by Alisher Khalykbayev on 07.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import UIKit

struct SkyDevice {
    
    enum AllModels {

        case simulator
        case unknown
        case iPhone(kind: iPhone)
        case iPad_OLD
        case iPad_NEW
        
        var rawValue: String {
            switch self {
            case .simulator:
                let model = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"]
                if let model = model, model.contains("iPhone") || model.contains("iPad") {
                    let modelName = UIDevice.current.mapToDevice(identifier: model)
                    return "simulator. Device: (\(modelName.rawValue)); id: \(model)"
                } else {
                    return "simulator"
                }
            case .unknown:
                return "unknown"
            case .iPhone(kind: let kind):
                return "iPhone" + kind.rawValue
            case .iPad_OLD:
                return "iPad"
            case .iPad_NEW:
                return "iPad"
            }
        }
    }
    
    enum iPhone: String {
        case _5
        case _5C
        case _5S
        case _6
        case _6_PLUS
        case _6S
        case _6s_PLUS
        case _7
        case _7_PLUS
        case _SE
        case _8
        case _8_PLUS
        case _X
        case _XS
        case _XS_MAX
        case _XR
        case _11
        case _11_PRO
        case _11_PRO_MAX
        case _12_MINI
        case _12
        case _12_PRO
        case _12_PRO_MAX
        case _SE_2
        case _13
        case _13_mini
        case _13_pro
        case _13_pro_max
        case _14
        case _14_plus
        case _14_pro
        case _14_pro_max
    }
    
    enum ScreenSize {
        case small
        case medium
        case large
        case veryLarge
    }
    
}
