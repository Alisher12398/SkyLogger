//
//  UIView + Extension.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 18.11.2021.
//

import UIKit

extension UIView {
    
    var safeArea: ConstraintBasicAttributesDSL {
        
        #if swift(>=3.2)
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
        #else
        return self.snp
        #endif
    }

    func reAddSubview(_ view: UIView) {
        view.snp.removeConstraints()
        view.removeFromSuperview()
        self.addSubview(view)
    }
    
    func reAddSubviews(_ views: [UIView]) {
        views.forEach({
            $0.snp.removeConstraints()
            $0.removeFromSuperview()
            self.addSubview($0)
        })
    }
    
    func removeSubview(_ view: UIView) {
        view.snp.removeConstraints()
        view.removeFromSuperview()
    }
    
    func removeSubviews(_ views: [UIView]) {
        views.forEach({
            $0.snp.removeConstraints()
            $0.removeFromSuperview()
        })
    }
    
}
