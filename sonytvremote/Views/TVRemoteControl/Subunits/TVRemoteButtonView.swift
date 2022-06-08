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
            Rectangle()
                .frame(width: 120, height: 60, alignment: .center)
                .cornerRadius(10)
                .foregroundColor(Theme.remoteButtonPrimaryColor)
                .overlay {
                    if buttonText != nil  {
                        Text(buttonText!)
                    } else if buttonImage != nil {
                        Image(systemName: buttonImage!)
                    }
                }
        }
        .foregroundColor(Theme.remoteButtonPrimaryTextColor)
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
