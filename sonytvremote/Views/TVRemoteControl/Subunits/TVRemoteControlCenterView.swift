//
//  TVRemoteControlCenterView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/24/22.
//

import SwiftUI

struct TVRemoteControlCenterView: View {
    var clickAction: ((_ buttonClicked: RemoteControlButton) -> ())
    
    var body: some View {
        ZStack {
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Rectangle()
                        .frame(width: 175, height: 175, alignment: .topLeading)
                        .foregroundColor(Theme.backgroundColor)
                        .overlay {
                            // Up
                            Button(action: {clickAction(RemoteControlButton.actionUp)}) {
                                TVRemoteControlCenterViewArc()
                                    .rotation(Angle(degrees: 180))
                                    .stroke(Theme.remoteButtonPrimaryColor, lineWidth: 100)
                            }
                            Image(systemName: "arrow.up.left")
                        }
                    
                    Rectangle()
                        .frame(width: 175, height: 175, alignment: .topLeading)
                        .foregroundColor(Theme.backgroundColor)
                        .overlay {
                            // Right
                            Button(action: {clickAction(RemoteControlButton.actionRight)}) {
                                TVRemoteControlCenterViewArc()
                                    .rotation(Angle(degrees: 270))
                                    .stroke(Theme.remoteButtonPrimaryColor, lineWidth: 100)
                            }
                            Image(systemName: "arrow.up.right")
                        }
                }
                .frame(width: 175, height: 175, alignment: .leading)
                
                HStack(spacing: 4) {
                    Rectangle()
                        .frame(width: 175, height: 175, alignment: .topLeading)
                        .foregroundColor(Theme.backgroundColor)
                        .overlay {
                            // Left
                            Button(action: {clickAction(RemoteControlButton.actionLeft)}) {
                                TVRemoteControlCenterViewArc()
                                    .rotation(Angle(degrees: 90))
                                    .stroke(Theme.remoteButtonPrimaryColor, lineWidth: 100)
                            }
                            Image(systemName: "arrow.down.left")
                        }
                    
                    Rectangle()
                        .frame(width: 175, height: 175, alignment: .topLeading)
                        .foregroundColor(Theme.backgroundColor)
                        .overlay {
                            // Down
                            Button(action: {clickAction(RemoteControlButton.actionDown)}) {
                                TVRemoteControlCenterViewArc()
                                    .rotation(Angle(degrees: 0))
                                    .stroke(Theme.remoteButtonPrimaryColor, lineWidth: 100)
                            }
                            Image(systemName: "arrow.down.right")
                        }
                }
                .frame(width: 175, height: 175, alignment: .leading)
            }
            .foregroundColor(Theme.remoteButtonPrimaryTextColor)
            .frame(width: 354, height: 354, alignment: .leading)
            .rotationEffect(.degrees(45))
            
            // Center
            Button(action: {clickAction(RemoteControlButton.actionConfirm)}) {
                Circle()
                    .frame(width: 156, height: 156, alignment: .center)
                    .foregroundColor(Theme.remoteButtonSecondaryColor)
            }
            
            // Shadow effect only
            Circle()
                .frame(width: 150, height: 150, alignment: .center)
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
            clickAction: { buttonClicked in
                
            }
        )
        .environment(\.colorScheme, .dark)
    }
}
