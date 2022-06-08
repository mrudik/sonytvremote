//
//  TVDevice.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/24/22.
//

import Foundation

struct TVDevice: Identifiable, Codable {
    var id: UUID
    var name: String
    var location: String
    var ipAddress: String
    var presharedKey: String
    
    init(id: UUID = UUID(), name: String, location: String, ipAddress: String, presharedKey: String) {
        self.id = id
        self.name = name
        self.location = location
        self.ipAddress = ipAddress
        self.presharedKey = presharedKey
    }
    
    init(id: UUID = UUID(), data: Data) {
        self.id = id
        self.name = data.name
        self.location = data.location
        self.ipAddress = data.ipAddress
        self.presharedKey = data.presharedKey
    }
}

extension TVDevice {
    static let sampleDeviceList: [TVDevice] = [
        TVDevice(name: "Samsung", location: "Living Room", ipAddress: "192.168.10.10", presharedKey: "123456"),
        TVDevice(name: "LG", location: "Bedroom", ipAddress: "192.168.10.11", presharedKey: "654321"),
    ]
    
    struct Data : Equatable {
        var deviceId: UUID? = nil
        var name: String = ""
        var location: String = ""
        var ipAddress: String = ""
        var presharedKey: String = ""
        var areRequiredFieldsEmpty = true
        
        mutating func validate() {
            if !name.isEmpty && !location.isEmpty && !presharedKey.isEmpty && isIPAddressValid() {
                areRequiredFieldsEmpty = false
            } else {
                areRequiredFieldsEmpty = true
            }
        }
        
        func isAnyDataPresent() -> Bool {
            !name.isEmpty || !location.isEmpty || !ipAddress.isEmpty || !presharedKey.isEmpty
        }
        
        private func isIPAddressValid() -> Bool {
            var result = false
            var sin = sockaddr_in()
            if !ipAddress.isEmpty {
                if ipAddress.withCString({ cstring in inet_pton(AF_INET, cstring, &sin.sin_addr) }) == 1 {
                    result = true
                }
            }
            return result
        }
    }
    
    var data: Data {
        Data(
            deviceId: id,
            name: name,
            location: location,
            ipAddress: ipAddress,
            presharedKey: presharedKey
        )
    }
    
    mutating func update(from: Data) {
        name = from.name
        location = from.location
        ipAddress = from.ipAddress
        presharedKey = from.presharedKey
    }
}
