//
//  SkyDevice.swift
//  OurMenu
//
//  Created by Alisher Khalykbayev on 07.11.2021.
//  Copyright © 2021 Alisher Khalykbayev. All rights reserved.
//

import Foundation

struct SkyDevice {
    
    enum AllModels {
        case simulator
        case unknown
        case iPhone(kind: iPhone)
        case iPad_OLD
        case iPad_NEW
    }
    
    enum iPhone {
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
