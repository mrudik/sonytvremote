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
                    Rectangle()
                        .frame(
                            width: dimension.arcFrame,
                            height: dimension.arcFrame,
                            alignment: .topLeading
                        )
                        .foregroundColor(.clear)
                        .overlay {
                            // Up
                            Button(action: {clickAction(RemoteControlButton.actionUp)}) {
                                TVRemoteControlCenterViewArc(arcRadius: dimension.arcRadius)
                                    .rotation(Angle(degrees: 180))
                                    .stroke(
                                        Theme.remoteButtonPrimaryColor,
                                        lineWidth: dimension.arcLineWidth
                                    )
                            }
                            Image(systemName: "arrow.up.left")
                        }
                    
                    Rectangle()
                        .frame(
                            width: dimension.arcFrame,
                            height: dimension.arcFrame,
                            alignment: .topLeading
                        )
                        .foregroundColor(.clear)
                        .overlay {
                            // Right
                            Button(action: {clickAction(RemoteControlButton.actionRight)}) {
                                TVRemoteControlCenterViewArc(arcRadius: dimension.arcRadius)
                                    .rotation(Angle(degrees: 270))
                                    .stroke(
                                        Theme.remoteButtonPrimaryColor,
                                        lineWidth: dimension.arcLineWidth
                                    )
                            }
                            Image(systemName: "arrow.up.right")
                        }
                }
                
                HStack(spacing: dimension.spacing) {
                    Rectangle()
                        .frame(
                            width: dimension.arcFrame,
                            height: dimension.arcFrame,
                            alignment: .topLeading
                        )
                        .foregroundColor(.clear)
                        .overlay {
                            // Left
                            Button(action: {clickAction(RemoteControlButton.actionLeft)}) {
                                TVRemoteControlCenterViewArc(arcRadius: dimension.arcRadius)
                                    .rotation(Angle(degrees: 90))
                                    .stroke(
                                        Theme.remoteButtonPrimaryColor,
                                        lineWidth: dimension.arcLineWidth
                                    )
                            }
                            Image(systemName: "arrow.down.left")
                        }
                    
                    Rectangle()
                        .frame(
                            width: dimension.arcFrame,
                            height: dimension.arcFrame,
                            alignment: .topLeading
                        )
                        .foregroundColor(.clear)
                        .overlay {
                            // Down
                            Button(action: {clickAction(RemoteControlButton.actionDown)}) {
                                TVRemoteControlCenterViewArc(arcRadius: dimension.arcRadius)
                                    .rotation(Angle(degrees: 0))
                                    .stroke(
                                        Theme.remoteButtonPrimaryColor,
                                        lineWidth: dimension.arcLineWidth
                                    )
                            }
                            Image(systemName: "arrow.down.right")
                        }
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
