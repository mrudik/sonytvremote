//
//  TVRemoteControlExtendedView.swift
//  TV Remote
//
//  Created by Maksim Rudik on 5/27/22.
//

import SwiftUI

struct TVRemoteControlExtendedView: View {
    var clickAction: ((_ buttonClicked: RemoteControlButton) -> ())
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                
                Text("VIDEO")
                Divider()
                
                HStack {
                    TVRemoteButtonView(
                        buttonText: "INPUT",
                        buttonType: .actionInput,
                        clickAction: clickAction
                    )
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    TVRemoteButtonView(
                        buttonText: "PREV",
                        buttonType: .actionPrev,
                        clickAction: clickAction
                    )
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    TVRemoteButtonView(
                        buttonText: "NEXT",
                        buttonType: .actionNext,
                        clickAction: clickAction
                    )
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)
                
                HStack {
                    TVRemoteButtonView(
                        buttonImage: "captions.bubble",
                        buttonType: .actionSubTitle,
                        clickAction: clickAction
                    )
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    TVRemoteButtonView(
                        buttonImage: "pause",
                        buttonType: .actionPause,
                        clickAction: clickAction
                    )
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    TVRemoteButtonView(
                        buttonImage: "play",
                        buttonType: .actionPlay,
                        clickAction: clickAction
                    )
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                Text("AUDIO")
                    .padding(.top)
                
                Divider()
                
                HStack {
                    TVRemoteButtonView(
                        buttonImage: "speaker.slash",
                        buttonType: .actionMute,
                        clickAction: clickAction
                    )
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    TVRemoteButtonView(
                        buttonImage: "speaker.wave.1",
                        buttonType: .actionVolumeDown,
                        clickAction: clickAction
                    )
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    TVRemoteButtonView(
                        buttonImage: "speaker.wave.3",
                        buttonType: .actionVolumeUp,
                        clickAction: clickAction
                    )
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding([.top, .bottom])
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Theme.backgroundColor)
        .foregroundColor(Theme.remoteButtonSecondaryColor)
    }
}

struct TVRemoteControlExtendedView_Previews: PreviewProvider {
    static var previews: some View {
        TVRemoteControlExtendedView() { buttonClicked in
            
        }
        .previewLayout(.sizeThatFits)
        .environment(\.colorScheme, .dark)
    }
}
