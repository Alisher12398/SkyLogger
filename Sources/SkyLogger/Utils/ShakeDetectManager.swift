//
//  ShakeDetectManager.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 09.06.2025.
//

import UIKit

public final class ShakeDetectManager {
    public static let shared = ShakeDetectManager()
    
    private init() {
        if SkyCustomization.shared.shakeToPresent {
            swizzleWindowMotion()
        }
    }
    
    func configure() {
        
    }
    
    private func swizzleWindowMotion() {
        guard
            let cls = NSClassFromString("UIWindow"),
            let orig = class_getInstanceMethod(cls, #selector(UIResponder.motionEnded(_:with:))),
            let imp = class_getInstanceMethod(ShakeDetectManager.self, #selector(shake_motionEnded(_:with:)))
        else {
            return
        }
        method_exchangeImplementations(orig, imp)
    }
    
    @objc private func shake_motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            guard SkyCustomization.shared.shakeToPresent else { return }
            Logger.presentLogList(presentingViewController: nil)
        }
        //        shake_motionEnded(motion, with: event)
    }
}
