//
//  sonytvremoteApp.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/22/22.
//

import SwiftUI

@main
struct sonytvremoteApp: App {
    @StateObject private var store = TVStore()
    @State private var errorWrapper: ErrorWrapper?
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TVPickerView(devices: $store.devices)
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .onAppear {
                // In order to change Form/List background color, we need to set this, as those views are backed by UITableView.
                UITableView.appearance().backgroundColor = .clear
            }
            .task {
                // Bind async task with a view. Will be called when view appears on screen.
                do {
                    store.devices = try await TVStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Unable to load your stored TV's information.")
                }
            }
            .sheet(item: $errorWrapper) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
