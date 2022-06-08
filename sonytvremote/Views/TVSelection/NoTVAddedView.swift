//
//  NoTVAddedView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/26/22.
//

import SwiftUI

struct NoTVAddedView: View {
    var addDeviceAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "tv")
                .font(.system(size: 64))
                .foregroundColor(.gray)
            
            Text("No TVs")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text("You have not added any TVs yet")
                .font(.body)
                .padding(.top)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button("Add a TV") {
                addDeviceAction()
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(Theme.backgroundColor)
            .controlSize(.large)
                    
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.backgroundColor)
    }
}

struct NoTVAddedView_Previews: PreviewProvider {
    static var previews: some View {
        NoTVAddedView(addDeviceAction: {})
            .environment(\.colorScheme, .dark)
    }
}
