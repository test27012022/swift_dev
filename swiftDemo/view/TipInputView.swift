//
//  TipInputView.swift
//  swiftDemo
//
//  Created by Dmitry P on 27.02.24.
//

import UIKit
class TipInputView: UIView {
    
    private let headerView: HeaderView = {
       let view = HeaderView()
        view.configure(
            topText: "Choose",
            bottomText: "your tip")
        return view
    }()
    
    private lazy var tenPercentButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        return button
    }()
    
    private lazy var fifteenPercentButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        return button
    }()
    
    private lazy var twentyPercentButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
       let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8)
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
        tenPercentButton,
        fifteenPercentButton,
        twentyPercentButton
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .horizontal
       return stackView
    }()
    
    private lazy var buttonVStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [
       buttonHStackView,
       customTipButton
       ])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layout() {
        
        addSubview(headerView)
        addSubview(buttonVStackView)
        
        buttonVStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(buttonHStackView.snp.centerY)
        }
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
            ])
        text.addAttributes([
            .font: ThemeFont.demiBold(ofSize: 14)
        ],range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}

