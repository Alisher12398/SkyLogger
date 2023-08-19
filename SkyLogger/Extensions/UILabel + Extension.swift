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
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        self.reAddSubview(view)
        NSLayoutConstraint.activate([
            view.rightAnchor.constraint(equalTo: self.leftAnchor, constant: -5),
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            view.widthAnchor.constraint(equalToConstant: 1.2)
        ])
    }
    
    //    func calculateMaxWidth() -> CGFloat {
    //        guard let text = self.text else { return 0 }
    //        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: frame.size.height)
    //        let attributes = [NSAttributedString.Key.font: self.font as Any]
    //        let string = NSAttributedString(string: text, attributes: attributes)
    //        let boundingRect = string.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, context: nil)
    //        return ceil(boundingRect.width)
    //    }
    
    func calculateMaxWidth() -> CGFloat {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: frame.size.height)
        let actualSize = self.sizeThatFits(maxSize)
        return actualSize.width
    }
    
}
