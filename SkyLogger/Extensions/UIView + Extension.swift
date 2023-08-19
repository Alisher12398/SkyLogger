//
//  UIView + Extension.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 18.11.2021.
//

import UIKit

extension UIView {

    func reAddSubview(_ view: UIView) {
        view.removeFromSuperview()
        self.addSubview(view)
    }
    
    func reAddSubviews(_ views: [UIView]) {
        views.forEach({
            $0.removeFromSuperview()
            self.addSubview($0)
        })
    }
    
    func removeSubview(_ view: UIView) {
        view.removeFromSuperview()
    }
    
    func removeSubviews(_ views: [UIView]) {
        views.forEach({
            $0.removeFromSuperview()
        })
    }
    
}
