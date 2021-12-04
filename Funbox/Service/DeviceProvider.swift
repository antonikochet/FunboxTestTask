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
    func buy(_ device: Device, completion: @escaping (Device?) -> Void)
}

protocol BackEndProviderProtocol: AnyObject {
    var countTable: Int { get }
    func getDevice(by index: Int) -> Device?
    func addDevice(_ device: Device, completion: @escaping () -> Void)
    func editingDevice(_ device: Device, index: Int, completion: @escaping () -> Void)
    func deleteDevice(index: Int, completion: @escaping () -> Void)
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
            DispatchQueue.global(qos: .background).async {
                self.storage.saveData(newValue)
            }
        }
    }
    
    private var storage: StorageProtocol
    
    private var queue = DispatchQueue(label: "queue", attributes: .concurrent)
    
    init(storage: StorageProtocol) {
        self.storage = storage
        self.devices = storage.getData()
    }
    
    private func queueBuy(completion: @escaping () -> Void) {
        queue.asyncAfter(deadline: .now() + .seconds(3), flags: .barrier) {
            completion()
        }
    }
    
    private func queueSave(completion: @escaping () -> Void) {
        queue.asyncAfter(deadline: .now() + .seconds(5), flags: .barrier) {
            completion()
        }
    }
    
    private func queueRead(completion: @escaping () -> Void) {
        queue.sync {
            completion()
        }
    }
}

extension DeviceProvider: StoreFrontProviderProtocol {
    
    var count: Int {
        var count = 0
        queueRead {
            count = self.devices.filter { $0.count != 0 }.count
        }
        return count
    }
    
    func view(with index: Int) -> Device? {
        var viewDeivce: Device?
        queueRead {
            let viewDevices = self.devices.filter { $0.count != 0 }
            if viewDevices.count > index {
                viewDeivce = viewDevices[index]
            }
        }
        return viewDeivce
    }
    
    func buy(_ device: Device, completion: @escaping (Device?) -> Void) {
        queueBuy {
            guard let index = self.devices.firstIndex(of: device) else {
                completion(nil)
                return
            }
            
            if self.devices[index].count > 1 {
                self.devices[index].count -= 1
            } else {
                self.devices[index].count = 0
            }
            completion(self.devices[index])
        }
    }
}

extension DeviceProvider: BackEndProviderProtocol {
    var countTable: Int {
        var count = 0
        queueRead {
            count = self.devices.count
        }
        return count
    }
    
    func getDevice(by index: Int) -> Device? {
        var viewDeivce: Device?
        queueRead {
            if self.devices.count > index && index >= 0 {
                viewDeivce = self.devices[index]
            }
        }
        return viewDeivce
    }
    
    func addDevice(_ device: Device, completion: @escaping () -> Void) {
        queueSave {
            self.devices.append(device)
            completion()
        }
    }
    
    func editingDevice(_ device: Device, index: Int, completion: @escaping () -> Void) {
        queueSave {
            self.devices[index] = device
            completion()
        }
    }
    
    func deleteDevice(index: Int, completion: @escaping () -> Void) {
        queueSave {
            self.devices.remove(at: index)
            completion()
        }
    }
}
