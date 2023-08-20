//
//  LogDetailView.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 26.11.2021.
//

import UIKit

class LogDetailView: SkyBaseView {
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.bounces = true
        tv.alwaysBounceVertical = true
        tv.alwaysBounceHorizontal = false
        tv.font = .regular(16)
        tv.isEditable = false
        tv.textColor = .skyTextWhite
        tv.clipsToBounds = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override init() {
        super.init()
        configure()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - SkyBaseViewProtocol
extension LogDetailView: SkyBaseViewProtocol {
    
    func configure() {
        backgroundColor = .skyBackground
    }
    
    func makeConstraints() {
        addSubview(textView)
        NSLayoutConstraint.activate([
            textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            textView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
}

//MARK: - Public Methods
extension LogDetailView {
    
    func setData(text: String) {
        textView.text = text
    }
    
}

//MARK: - Private Methods
private extension LogDetailView {
    
}

