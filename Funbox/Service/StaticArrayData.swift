//
//  StaticArrayData.swift
//  Funbox
//
//  Created by Антон Кочетков on 29.11.2021.
//

import Foundation

class StaticArrayData: StorageProtocol {
    func getData() -> [Device] {
        return [Device(name: "Apple iPod touch 5 32Gb", price: 8888, count: 5),
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
    
    func saveData(_ devices: [Device]) {
        //реализация для сохранения данных в какое-то хранилище
        print("Сохранение данных: ", devices)
    }
}


