//
//  DeviceProvider.swift
//  Funbox
//
//  Created by Антон Кочетков on 23.11.2021.
//

import Foundation

//MARK: - protocols for view screen
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

//MARK: - protocol for adapter target
protocol StorageProtocol {
    func getData() -> [Device]
    func saveData(_ devices: [Device])
}

//MARK: - class for storage data and implementation protocols
class DeviceProvider {
    private var devices: [Device] {
        willSet {
            storage.saveData(newValue)
        }
    }
    
    private var storage: StorageProtocol
    
    init(storage: StorageProtocol) {
        self.storage = storage
        self.devices = storage.getData()
    }
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
