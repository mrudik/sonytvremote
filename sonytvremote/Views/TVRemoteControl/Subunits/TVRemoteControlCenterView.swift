//
//  TVRemoteControlCenterView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/24/22.
//

import SwiftUI

struct TVRemoteControlCenterView: View {
    let dimension: TVButtonDimension
    
    var clickAction: ((_ buttonClicked: RemoteControlButton) -> ())
    
    var body: some View {
        ZStack {
            VStack(spacing: dimension.spacing) {
                HStack(spacing: dimension.spacing) {
                    // Up
                    TVRemoteControlArrowButtonView(
                        dimension: dimension,
                        rotationAngle: 180,
                        systemImage: "arrow.up.left",
                        clickAction: {clickAction(RemoteControlButton.actionUp)}
                    )
                    
                    // Right
                    TVRemoteControlArrowButtonView(
                        dimension: dimension,
                        rotationAngle: 270,
                        systemImage: "arrow.up.right",
                        clickAction: {clickAction(RemoteControlButton.actionRight)}
                    )
                }
                
                HStack(spacing: dimension.spacing) {
                    // Left
                    TVRemoteControlArrowButtonView(
                        dimension: dimension,
                        rotationAngle: 90,
                        systemImage: "arrow.down.left",
                        clickAction: {clickAction(RemoteControlButton.actionLeft)}
                    )
                    
                    // Down
                    TVRemoteControlArrowButtonView(
                        dimension: dimension,
                        rotationAngle: 0,
                        systemImage: "arrow.down.right",
                        clickAction: {clickAction(RemoteControlButton.actionDown)}
                    )
                }
            }
            .foregroundColor(Theme.remoteButtonPrimaryTextColor)
            .frame(
                width: dimension.outerCircleFrame,
                height: dimension.outerCircleFrame,
                alignment: .leading
            )
            .rotationEffect(.degrees(45))
            
            // Center
            Button(action: {clickAction(RemoteControlButton.actionConfirm)}) {
                Circle()
                    .frame(
                        width: dimension.innerCircleDiameter,
                        height: dimension.innerCircleDiameter,
                        alignment: .center
                    )
                    .foregroundColor(Theme.remoteButtonSecondaryColor)
            }
            
            // Shadow effect only
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
        .background(Theme.backgroundColor)
    }
}

struct TVRemoteControlCenterView_Previews: PreviewProvider {
    static var previews: some View {
        TVRemoteControlCenterView(
            dimension: TVButtonDimension(),
            clickAction: { buttonClicked in
                
            }
        )
        .environment(\.colorScheme, .dark)
    }
}
