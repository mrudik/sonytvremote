//
//  TVRemoteButtonView.swift
//  TV Remote
//
//  Created by Maksim Rudik on 5/27/22.
//

import SwiftUI

struct TVRemoteButtonView: View {
    var buttonText: String? = nil
    var buttonImage: String? = nil
    let buttonType: RemoteControlButton
    var clickAction: ((_ buttonClicked: RemoteControlButton) -> ())
    
    var body: some View {
        Button(action: {clickAction(buttonType)}) {
            HStack(spacing: 0) {
                Spacer()
                
                if buttonText != nil  {
                    Text(buttonText!)
                        .font(.body)
                        .lineLimit(1)
                        .scaledToFill()
                } else if buttonImage != nil {
                    Image(systemName: buttonImage!)
                        .font(.body)
                }
                
                Spacer()
            }
            .frame(width: .infinity, height: UIScreen.main.bounds.height * 0.06)
            .background(Theme.remoteButtonPrimaryColor)
            .cornerRadius(10)
            .foregroundColor(Theme.remoteButtonPrimaryTextColor)
        }
    }
}

struct TVRemoteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TVRemoteButtonView(
            buttonText: "TEXT",
            buttonType: .actionHome,
            clickAction: { buttonClicked in
                
            }
        )
        .environment(\.colorScheme, .dark)
    }
}
