//
//  ErrorView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/24/22.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    
    // We'll access view's dismiss structure and call it like a function to dismiss the view.
    // We can call a structure like a function if it includes callAsFunction()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 64))
                    .padding(.bottom)
                
                Text("An error has occured")
                    .font(.title)
                    .padding(.bottom)
                
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                    .padding(.top)
                
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .background(Theme.backgroundColor)
            //.foregroundColor(Theme.remoteButtonSecondaryColor)
            .navigationTitle("Error")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }
    
    static var wrapper: ErrorWrapper {
        ErrorWrapper(
            error: SampleError.errorRequired,
            guidance: "You can safely ignore this sample error."
        )
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
            .environment(\.colorScheme, .dark)
    }
}
