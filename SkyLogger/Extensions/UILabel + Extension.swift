//
//  UILabel + Extension.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 26.11.2021.
//

import UIKit

extension UILabel {
    
    func addLeftVerticalLine(checkIsEmpty: Bool) {
        if checkIsEmpty, self.text?.isEmpty ?? true {
            return
        }
        let v = UIView()
        v.backgroundColor = .textSecondary
        self.reAddSubview(v)
        v.snp.makeConstraints({
            $0.right.equalTo(self.snp.left).offset(-5)
            $0.top.equalToSuperview().offset(2)
            $0.bottom.equalToSuperview().offset(-2)
            $0.width.equalTo(1.2)
        })
    }
    
}
