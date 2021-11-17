//
//  BaseView.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit
import SnapKit

protocol BaseViewProtocol {
    func configure()
    func makeConstraints()
}

class BaseView: UIView {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = Customization.shared.backgroundColor
    }
    
}

