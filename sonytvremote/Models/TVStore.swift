//
//  TVStore.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/24/22.
//

import Foundation
import SwiftUI

class TVStore: ObservableObject {
    @Published var devices: [TVDevice] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent("devices.data")
    }
    
    static func load(completion: @escaping (Result<[TVDevice], Error>) -> Void) {
        // DispatchQueue are First In, First Out (FIFO) queues to which app can submit tasks.
        // Background tasks have the lowest priority of all tasks.
        
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    // Because devices.data does not exist when a user launches the app for the first time,
                    // We call the completion handler with an empty array if there is an error opening the file handle.
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                
                let devices = try JSONDecoder().decode([TVDevice].self, from: file.availableData)
                
                DispatchQueue.main.async {
                    completion(.success(devices))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(devices: [TVDevice], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(devices)
                let file = try fileURL()
                try data.write(to: file)
                
                DispatchQueue.main.async {
                    completion(.success(devices.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func load() async throws -> [TVDevice] {
        // Calling withCheckedThrowingContinuation suspends the load function,
        // Then passes a continuation into a closure that you provide.
        // A continuation is a value that represents the code after an awaited function.
        
        // Continuations have methods for returning a value, returning a Result, and throwing an error.
        
        try await withCheckedThrowingContinuation { continuation in
            // Calling legacy load function with a completion handler
            load { result in
                switch result {
                case .failure(let error):
                    // Send the error to continuation closure
                    continuation.resume(throwing: error)
                case .success(let devices):
                    // Send the devices to the continuation closure
                    // The array of devices becomes the result of the withCheckedThrowingContinuation call when the async task resumes.
                    continuation.resume(returning: devices)
                }
            }
        }
    }
    
    @discardableResult // disables warnings about the unused return value
    static func save(devices: [TVDevice]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(devices: devices) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let devicesSaved):
                    continuation.resume(returning: devicesSaved)
                }
            }
        }
    }
}

extension Array where Element == TVDevice {
    mutating func removeDeviceById(id: UUID?) {
        guard id != nil else {
            return
        }
        
        for (index, device) in self.enumerated() {
            if device.id == id {
                self.remove(at: index)
                break
            }
        }
    }
}
