//
//  UIColor+Hex.swift
//  SkyLogger
//

import UIKit

extension UIColor {

    /// Constructs a color from a hex string (3 or 6 hex digits, leading `#` optional).
    /// Falls back to transparent white on malformed input.
    convenience init(hex string: String) {
        var hex = string.hasPrefix("#") ? String(string.dropFirst()) : string
        if hex.count == 3 {
            hex = hex.map({ "\($0)\($0)" }).joined()
        }
        guard hex.count == 6, let code = Int(hex, radix: 16) else {
            self.init(white: 1.0, alpha: 0.0)
            return
        }
        self.init(
            red: CGFloat((code >> 16) & 0xFF) / 255,
            green: CGFloat((code >> 8) & 0xFF) / 255,
            blue: CGFloat(code & 0xFF) / 255,
            alpha: 1.0
        )
    }
}
