//
//  ViewController.swift
//  Funbox
//
//  Created by Антон Кочетков on 23.11.2021.
//

import UIKit

class StoreFrontContentViewController: UIViewController {

    private var nameDeviceLabel: UILabel?
    private var priceLabel: UILabel?
    private var countLabel: UILabel?
    private var buyButton: UIButton?
    
    var pageNumber: Int = 0
    var buy: ((Device) -> Void)?
    
    var device: Device!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMainStackView()
        view.backgroundColor = .white
        buyButton?.addTarget(self, action: #selector(buyAction), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configure()
    }
    private func configure() {
        nameDeviceLabel?.text = device.name
        priceLabel?.text = "\(device.price) руб."
        countLabel?.text = "\(device.count) шт."
    }
    
    private func createMainStackView() {
        //name device label
        let nameDeviceLabel = UILabel.createLabel(title: "-")
        nameDeviceLabel.font = UIFont.systemFont(ofSize: 30)
        self.nameDeviceLabel = nameDeviceLabel
        
        //price stack
        let (priceStackView, priceLabel) = createHorizontalStackView(title: "Цена")
        self.priceLabel = priceLabel
        self.priceLabel?.text = "-"
        
        //count stack
        let (countStackView, countLabel) = createHorizontalStackView(title: "Количество")
        self.countLabel = countLabel
        self.countLabel?.text = "-"
        //button
        let viewButton = createViewButton()
        
        let mainStackView = UIStackView(arrangedSubviews: [nameDeviceLabel, priceStackView, countStackView, viewButton])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        
    }
    
    private func createHorizontalStackView(title: String) -> (UIStackView, UILabel) {
        let staticLabel = UILabel.createLabel(title: title)
        staticLabel.font = UIFont.systemFont(ofSize: 30)
        
        let label = UILabel.createLabel(title: title)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .systemGray2
        
        let stackView = UIStackView(arrangedSubviews: [staticLabel, label])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return (stackView, label)
    }
    
    private func createViewButton() -> UIView {
        let button = UIButton()
        button.setTitle("Купить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.buyButton = button
        
        let viewButton = UIView()
        viewButton.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: viewButton.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: viewButton.centerYAnchor),
            button.widthAnchor.constraint(equalTo: viewButton.widthAnchor, multiplier: 0.5),
            button.heightAnchor.constraint(equalTo: viewButton.heightAnchor, multiplier: 0.35)])
        
        return viewButton
    }
    
    @objc private func buyAction() {
        buy?(device)
        configure()
    }
}

