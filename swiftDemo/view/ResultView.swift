//
//  ResultView.swift
//  swiftDemo
//
//  Created by Dmitry P on 27.02.24.
//

import UIKit
class ResultView: UIView {
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layout() {
        backgroundColor = .green
    }
    
}