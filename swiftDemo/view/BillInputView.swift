//
//  BillInputView.swift
//  swiftDemo
//
//  Created by Dmitry P on 27.02.24.
//

import UIKit
import Combine
import CombineCocoa

class BillInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Enter", bottomText: "your bill")
       return view
    }()
    
    private let textFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(radius: 8.0)
        return view
    }()
    
    private let currencyDenominationLabel: UILabel = {
        let label = LabelFactory.buildLabel(
            text: "$",
            font: ThemeFont.bold(ofSize: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.font = ThemeFont.demiBold(ofSize: 28)
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.tintColor = ThemeColor.text
        textField.textColor = ThemeColor.text
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped))
        
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            doneButton
        ]
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
        return textField
    }()
    
    private let billSubject: PassthroughSubject<Double, Never> = .init() // 3. здесь храним инфу с текстфилд
    
    var valuePublisher: AnyPublisher<Double, Never> { //4. отсюда транслируем на весь проект инфу с billSubject
        return billSubject.eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func observe() {
        textField.textPublisher.sink { [unowned self] text in // 1. забираем инфу с текстфилд
            billSubject.send(text?.doubleValue ?? 0) // 2. передаем через трансформацию "текст в дабл" в billSubject
        }.store(in: &cancellables)
    }
  
    private func layout() {
        [headerView, textFieldContainerView].forEach(addSubview(_:))
//   тоже самое что и      addSubview(headerView)
//        addSubview(textFieldContainerView)
        textFieldContainerView.addSubview(currencyDenominationLabel)
        textFieldContainerView.addSubview(textField)
        
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
            make.width.equalTo(68)
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        currencyDenominationLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
            
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currencyDenominationLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
    }
    
    @objc private func doneButtonTapped() {
        textField.endEditing(true)
    }
}

