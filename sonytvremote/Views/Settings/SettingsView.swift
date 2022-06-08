//
//  SettingsView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/26/22.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    private var appVersion: String {
        var appVersion = "1.0"
        let bundleVersionObject: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        if bundleVersionObject != nil {
            appVersion = bundleVersionObject!
        }
        return appVersion
    }
    
    var body: some View {
        VStack {
            Form {
                Section("Appearance") {
                    Toggle("Dark mode", isOn: $isDarkMode)
                        .tint(Theme.navBarConfirmationTextColor)
                }
            }
            
            Text("App version: \(appVersion)")
                .font(.caption)
                .foregroundColor(.gray)
            Text("Developer: @mrudik")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .background(Theme.backgroundColor)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
