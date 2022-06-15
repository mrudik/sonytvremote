//
//  TVRemoteControlBottomView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/26/22.
//

import SwiftUI

struct TVRemoteControlBottomView: View {
    let dimension: TVButtonDimension
    
    var clickAction: ((_ buttonClicked: RemoteControlButton) -> ())
    
    var body: some View {
        HStack {
            TVRemoteButtonView(
                buttonImage: "arrowtriangle.backward",
                buttonType: .actionBack,
                clickAction: clickAction
            )
            .frame(minWidth: 0, maxWidth: .infinity)
            
            TVRemoteButtonView(
                buttonText: "PIC OFF",
                buttonType: .actionPictureOff,
                clickAction: clickAction
            )
            .frame(minWidth: 0, maxWidth: .infinity)
            
            TVRemoteButtonView(
                buttonImage: "house",
                buttonType: .actionHome,
                clickAction: clickAction
            )
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .background(Theme.backgroundColor)
        .foregroundColor(Theme.remoteButtonPrimaryTextColor)
    }
}

struct TVRemoteControlBottomView_Previews: PreviewProvider {
    static var previews: some View {
        TVRemoteControlBottomView(
            dimension: TVButtonDimension(),
            clickAction: { buttonClicked in
            }
        )
        .environment(\.colorScheme, .dark)
    }
}
