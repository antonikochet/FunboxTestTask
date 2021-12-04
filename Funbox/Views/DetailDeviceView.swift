//
//  DetailDeviceView.swift
//  Funbox
//
//  Created by Антон Кочетков on 24.11.2021.
//

import UIKit

class DetailDeviceView: UIView {

    private let nameDeviceLabel: UILabel = {
        let label = UILabel.createLabel(title: "Название")
        return label
    }()

    let nameDeviceTextField: UITextField = {
        let textField = UITextField.createTextField(placeholder: "Название девайса")
        return textField
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel.createLabel(title: "Цена")
        return label
    }()
    
    let priceTextField: UITextField = {
        let textField = UITextField.createTextField(placeholder: "Укажите цену в руб.")
        textField.keyboardType = .asciiCapableNumberPad
        return textField
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel.createLabel(title: "Количество")
        return label
    }()
    
    let countTextField: UITextField = {
        let textField = UITextField.createTextField(placeholder: "Количество в штуках")
        textField.keyboardType = .asciiCapableNumberPad
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, price: Double, count: Int) {
        nameDeviceTextField.text = name
        priceTextField.text = "\(price)"
        countTextField.text = "\(count)"
    }
    
    private func addSubviews() {
        addSubview(nameDeviceLabel)
        addSubview(nameDeviceTextField)
        addSubview(priceLabel)
        addSubview(priceTextField)
        addSubview(countLabel)
        addSubview(countTextField)
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            nameDeviceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            nameDeviceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameDeviceLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.03),
            nameDeviceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            
            nameDeviceTextField.topAnchor.constraint(equalTo: nameDeviceLabel.bottomAnchor, constant: 8),
            nameDeviceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameDeviceTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        
            priceLabel.topAnchor.constraint(equalTo: nameDeviceTextField.bottomAnchor, constant: 40),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            priceLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.03),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            
            priceTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            priceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            priceTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        
            countLabel.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 40),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            countLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.03),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),

            countTextField.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 8),
            countTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            countTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        super.updateConstraints()
    }
    
    
}

