//
//  String + Extension.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 18.11.2021.
//

import UIKit

extension String {
    
    func width(font: UIFont) -> CGFloat {
        guard !self.isEmpty else { return 0 }
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes).width
    }
    
    
}
