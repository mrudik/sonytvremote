//
//  TVRemoteControlBottomView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/26/22.
//

import SwiftUI

struct TVRemoteControlBottomView: View {
    var clickAction: ((_ buttonClicked: RemoteControlButton) -> ())
    
    var body: some View {
        HStack {
            TVRemoteButtonView(
                buttonImage: "arrowtriangle.backward",
                buttonType: .actionBack,
                clickAction: clickAction
            )
            
            TVRemoteButtonView(
                buttonText: "SCREEN",
                buttonType: .actionPictureOff,
                clickAction: clickAction
            )
            
            TVRemoteButtonView(
                buttonImage: "house",
                buttonType: .actionHome,
                clickAction: clickAction
            )
        }
        .background(Theme.backgroundColor)
        .foregroundColor(Theme.remoteButtonPrimaryTextColor)
    }
}

struct TVRemoteControlBottomView_Previews: PreviewProvider {
    static var previews: some View {
        TVRemoteControlBottomView(clickAction: { buttonClicked in
            
        })
        .environment(\.colorScheme, .dark)
    }
}
