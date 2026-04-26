//
//  ShakeDetectManager.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 09.06.2025.
//

import UIKit

public final class ShakeDetectManager {
    public static let shared = ShakeDetectManager()

    private static var didSwizzle = false

    private init() {}

    func configure() {
        Self.swizzleIfNeeded()
    }

    private static func swizzleIfNeeded() {
        guard !didSwizzle else { return }
        let cls = UIWindow.self
        guard
            let orig = class_getInstanceMethod(cls, #selector(UIResponder.motionEnded(_:with:))),
            let new = class_getInstanceMethod(cls, #selector(UIWindow.sky_motionEnded(_:with:)))
        else {
            return
        }
        method_exchangeImplementations(orig, new)
        didSwizzle = true
    }
}

private extension UIWindow {

    @objc func sky_motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        // After exchange, this selector points to the original implementation — call it first.
        sky_motionEnded(motion, with: event)
        guard motion == .motionShake, SkyConfiguration.shared.shakeToPresent else { return }
        Logger.presentLogList(presentingViewController: nil)
    }
}
