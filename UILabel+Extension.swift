//
//  UILabel+Extension.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 22.11.2021.
//

import UIKit

extension UILabel {
    
    func addLeftVerticalLine() {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black
        self.reAddSubview(lineView)
        lineView.snp.makeConstraints({
            $0.right.equalTo(self.snp.left).offset(-6)
            $0.top.equalTo(self.snp.top).offset(2)
            $0.bottom.equalTo(self.snp.bottom).inset(2)
            $0.width.equalTo(1)
        })
    }
    
}
