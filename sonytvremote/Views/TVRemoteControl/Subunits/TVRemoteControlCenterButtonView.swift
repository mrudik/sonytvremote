//
//  TVRemoteControlCenterButtonView.swift
//  TV Remote
//
//  Created by Maksim Rudik on 6/14/22.
//

import SwiftUI

struct TVRemoteControlCenterButtonView: View {
    let dimension: TVButtonDimension
    let clickAction: () -> Void
    
    var body: some View {
        ZStack {
            Button(action: clickAction) {
                Circle()
                    .frame(
                        width: dimension.innerCircleDiameter,
                        height: dimension.innerCircleDiameter,
                        alignment: .center
                    )
                    .foregroundColor(Theme.remoteButtonSecondaryColor)
            }
            
            // Shadow effect
            Circle()
                .frame(
                    width: dimension.innerCircleShadowDiameter,
                    height: dimension.innerCircleShadowDiameter,
                    alignment: .center
                )
                .foregroundColor(Theme.remoteButtonSecondaryColor)
                .allowsHitTesting(false)
                .shadow(radius: 10)
        }
    }
}

struct TVRemoteControlCenterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TVRemoteControlCenterButtonView(
            dimension: TVButtonDimension(),
            clickAction: {}
        )
    }
}
