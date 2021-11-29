//
//  DeviceProvider.swift
//  Funbox
//
//  Created by Антон Кочетков on 23.11.2021.
//

import Foundation

protocol StoreFrontProviderProtocol: AnyObject {
    var count: Int { get }
    func view(with index: Int) -> Device?
    func buy(_ device: Device) -> Device?
}

protocol BackEndProviderProtocol: AnyObject {
    var countTable: Int { get }
    func getDevice(by index: Int) -> Device?
    func addDevice(_ device: Device)
    func editingDevice(_ device: Device, index: Int)
    func deleteDevice(index: Int)
}

class DeviceProvider {
    private var devices: [Device] = [Device(name: "Apple iPod touch 5 32Gb", price: 8888, count: 5),
                                     Device(name: "Samsung Galaxy S Duos S7562", price: 7230, count: 2),
                                     Device(name: "Canon EOS 600D Kit", price: 15659, count: 4),
                                     Device(name: "Samsung Galaxy Tab 2 10.1 P5100 16Gb", price: 13290, count: 9),
                                     Device(name: "PocketBook Touch", price: 5197, count: 2),
                                     Device(name: "Samsung Galaxy Note II 16Gb", price: 17049.50, count: 2),
                                     Device(name: "Nikon D3100 Kit", price: 12190, count: 4),
                                     Device(name: "Canon EOS 1100D Kit", price: 10985, count: 2),
                                     Device(name: "Sony Xperia acro S", price: 11800.99, count: 1),
                                     Device(name: "Lenovo G580", price: 8922, count: 1)]
}

extension DeviceProvider: StoreFrontProviderProtocol {
    
    var count: Int {
        return devices.filter { $0.count != 0 }.count
    }
    
    func view(with index: Int) -> Device? {
        let viewDevices = devices.filter { $0.count != 0 }
        if viewDevices.count > index {
            return viewDevices[index]
        } else {
            return nil
        }
    }
    
    func buy(_ device: Device) -> Device? {
        guard let index = devices.firstIndex(of: device) else { return nil }
        
        if devices[index].count > 1 {
            devices[index].count -= 1
        } else {
            devices[index].count = 0
        }
        return devices[index]
    }
}

extension DeviceProvider: BackEndProviderProtocol {
    var countTable: Int {
        return devices.count
    }
    
    func getDevice(by index: Int) -> Device? {
        if devices.count > index && index >= 0 {
            return devices[index]
        } else {
            return nil
        }
    }
    
    func addDevice(_ device: Device) {
        devices.append(device)
    }
    
    func editingDevice(_ device: Device, index: Int) {
        devices[index] = device
    }
    
    func deleteDevice(index: Int) {
        devices.remove(at: index)
    }
}
