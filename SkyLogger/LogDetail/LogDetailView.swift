//
//  LogDetailView.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 26.11.2021.
//

import UIKit

class LogDetailView: BaseView {
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.bounces = true
        tv.alwaysBounceVertical = true
        tv.alwaysBounceHorizontal = false
        tv.font = .regular(16)
        tv.isEditable = false
        tv.textColor = .backgroundLight
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

//MARK:- BaseViewProtocol
extension LogDetailView: BaseViewProtocol {
    
    func configure() {
        backgroundColor = .background
    }
    
    func makeConstraints() {
        addSubview(textView)
        textView.snp.makeConstraints({
            $0.top.equalTo(safeArea.top)
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16)
        })
    }
    
}

//MARK:- Public Methods
extension LogDetailView {
    
    func setData(text: String) {
        textView.text = text
    }
    
}

//MARK:- Private Methods
private extension LogDetailView {
    
}

