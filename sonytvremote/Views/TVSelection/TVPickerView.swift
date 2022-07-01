//
//  ContentView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/22/22.
//

import SwiftUI

struct TVPickerView: View {
    @Binding var devices: [TVDevice]
    
    @State private var isPresentingNewTVDeviceView = false
    @State private var newTVDeviceData = TVDevice.Data()
    
    func saveDevices() {
        Task {
            // Task creates a new async context.
            do {
                try await TVStore.save(devices: devices)
            } catch {
                // Nothing required
            }
        }
    }
    
    var body: some View {
        VStack {
            if devices.isEmpty {
                NoTVAddedView() {
                    isPresentingNewTVDeviceView = true
                }
            } else {
                List {
                    ForEach($devices) { $device in
                        NavigationLink(destination: TVRemoteView(devices: $devices, device: $device)) {
                            TVDeviceCellView(device: device)
                        }
                    }
                    
                    // Settings
                    NavigationLink(destination: SettingsView()) {
                        TVSettingsCellView()
                    }
                }
                .background(Theme.backgroundColor)
            }
        }
        .navigationTitle("Select a TV")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if !devices.isEmpty {
                Button(action: {
                    isPresentingNewTVDeviceView = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewTVDeviceView) {
            NavigationView {
                TVDetailsView(devices: $devices, data: $newTVDeviceData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewTVDeviceView = false
                                newTVDeviceData = TVDevice.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newTVDevice = TVDevice(data: newTVDeviceData)
                                devices.append(newTVDevice)
                                
                                saveDevices()
                                
                                isPresentingNewTVDeviceView = false
                                newTVDeviceData = TVDevice.Data()
                            }
                            .tint(Theme.navBarConfirmationTextColor)
                            .disabled(newTVDeviceData.areRequiredFieldsEmpty)
                        }
                    }
            }
        }
    }
}

struct TVPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TVPickerView(
            devices: .constant(TVDevice.sampleDeviceList)
        )
        //.environment(\.colorScheme, .dark)
    }
}
