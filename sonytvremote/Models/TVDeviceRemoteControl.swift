//
//  TVDeviceRemoteControl.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/25/22.
//

import SwiftUI
import AVFAudio
import AVFoundation
import MediaPlayer

class TVDeviceRemoteControl: NSObject, ObservableObject {
    private var device: TVDevice? = nil
    private var currentVolume: Float = 0.0
    
    @Published var errorWrapper: ErrorWrapper? = nil
    @Published var isErrorOccured: Bool = false
    
    func bindTV(device: TVDevice) {
        self.device = device
    }
    
    func click(button: RemoteControlButton) {
        guard device != nil else {
            return
        }
        
        sendRequest(IRCCCode: button.IRCCCode)
    }
    
    private func getDeviceURL() -> URL? {
        guard device != nil else {
            return nil
        }
        
        let networkProtocol = "http://"
        let baseUrl = "/sony/IRCC"
        
        return URL(string: "\(networkProtocol)\(device!.ipAddress)\(baseUrl)")
    }
    
    private func getSoapBody(IRCCCode: String) -> String {
        #"<?xml version="1.0"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><s:Body><u:X_SendIRCC xmlns:u="urn:schemas-sony-com:service:IRCC:1"><IRCCCode>"# + IRCCCode + #"</IRCCCode></u:X_SendIRCC></s:Body></s:Envelope>"#
    }
    
    private func prepareRequest(IRCCCode: String) -> URLRequest? {
        let url = getDeviceURL()
        
        if url == nil {
            return nil
        }
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.timeoutInterval = 5
        
        // Headers
        request.addValue("text/xml; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue(#""urn:schemas-sony-com:service:IRCC:1#X_SendIRCC""#, forHTTPHeaderField: "SOAPAction")
        request.addValue(device!.presharedKey, forHTTPHeaderField: "X-Auth-PSK")
        
        // Body
        request.httpBody = getSoapBody(IRCCCode: IRCCCode).data(using: .utf8)
        
        return request
    }
    
    private func sendRequest(IRCCCode: String) {
        let request = prepareRequest(IRCCCode: IRCCCode)
        
        if request == nil {
            return
        }
        
        let task = URLSession.shared.dataTask(with: request!) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else { // check for fundamental networking error
                self.errorWrapper = ErrorWrapper(
                    error: error ?? URLError(.badServerResponse),
                    guidance: "Your TV not responding. \nPlease check IP Address and Pre-Shared Key are correct.\nTV must be in the same Wi-Fi network as your mobile device."
                )
                self.isErrorOccured = true
                return
            }
        }
        task.resume()
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
