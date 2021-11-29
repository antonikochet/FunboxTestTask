//
//  DetailDeviceViewController.swift
//  Funbox
//
//  Created by Антон Кочетков on 24.11.2021.
//

import UIKit

protocol AddDeviceDelegate {
    func addDevice(_ device: Device)
}

protocol EditDeviceDelegate {
    func editDevice(_ device: Device)
}

class DetailViewController: UIViewController {

    private lazy var deviceView: DetailDeviceView = {
        let view = DetailDeviceView(frame: self.view.frame)
        return view
    }()
    
    var currectDevice: Device?
    
    var delegateAdd: AddDeviceDelegate!
    var delegateEdit: EditDeviceDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(deviceView)
        deviceView.updateConstraints()
        setupNavigationBar()
        view.backgroundColor = .white
        setupEditScreen()
    }

    private func setupNavigationBar() {
        let leftNavItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        leftNavItem.tintColor = .black
        
        let rightNavItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        rightNavItem.tintColor = .black
        
        navigationItem.leftBarButtonItem = leftNavItem
        navigationItem.rightBarButtonItem = rightNavItem
    }
    
    @objc private func cancelAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveAction() {
        if let name = deviceView.nameDeviceTextField.text,
           !name.isEmpty,
           let price = deviceView.priceTextField.text?.toDouble(),
           let count = deviceView.countTextField.text?.toInt() {
            let device = Device(name: name, price: price, count: count)
            if currectDevice == nil {
                delegateAdd.addDevice(device)
            } else {
                delegateEdit.editDevice(device)
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupEditScreen() {
        if currectDevice != nil {
            deviceView.configure(name: currectDevice!.name, price: currectDevice!.price, count: currectDevice!.count)
        }
    }
}

extension String {
    fileprivate func toDouble() -> Double? {
        return Double(self)
    }
    
    fileprivate func toInt() -> Int? {
        return Int(self)
    }
}
