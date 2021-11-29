//
//  Device.swift
//  Funbox
//
//  Created by Антон Кочетков on 23.11.2021.
//

import Foundation

struct Device {
    var name: String
    var price: Double
    var count: Int
}

extension Device: Equatable {
    static func == (_ ld: Device, _ rd: Device) -> Bool {
        return ld.name == rd.name &&
                ld.price == rd.price &&
                ld.count == rd.count
    }
}
