//
//  extensions+UIVIews.swift
//  Funbox
//
//  Created by Антон Кочетков on 25.11.2021.
//

import UIKit

extension UILabel {
    static func createLabel(title: String) -> UILabel{
        let label = UILabel()
        label.text = title
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension UITextField {
    static func createTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
}

