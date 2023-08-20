//
//  SkyBaseView.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 16.11.2021.
//

import UIKit

protocol SkyBaseViewProtocol {
    func configure()
    func makeConstraints()
}

class SkyBaseView: UIView {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .skyBackground
    }
    
}

