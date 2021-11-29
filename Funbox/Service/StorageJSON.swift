//
//  StorageJSON.swift
//  Funbox
//
//  Created by Антон Кочетков on 29.11.2021.
//

import Foundation

class StorageJSON {
    func convertFromJSON() -> [Device]{
        let dataString = """
        [{ "name": "apple iphone", "price": 1000.0, "count": 1 },
         { "name": "apple ipod", "price": 900.0, "count": 2 },
         { "name": "apple ipad", "price": 1300.0, "count": 1 }]
        """
        let devices = try? JSONDecoder().decode([Device].self, from: Data(dataString.utf8))
        return devices ?? []
    }
    
    func convertInJSON(_ devices: [Device]){
        let encodeDevices = try? JSONEncoder().encode(devices)
        let strData = String(decoding: encodeDevices!, as: UTF8.self)
        print(strData)
    }
}

class StorageJSONAdapter: StorageProtocol {
    
    private var storageJSON: StorageJSON
    
    init(storage: StorageJSON) {
        storageJSON = storage
    }
    
    func getData() -> [Device] {
        return storageJSON.convertFromJSON()
    }
    
    func saveData(_ devices: [Device]) {
        storageJSON.convertInJSON(devices)
    }
}

extension Device: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case count
      }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(count, forKey: .count)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Double.self, forKey: .price)
        count = try container.decode(Int.self, forKey: .count)
    }
    
}
