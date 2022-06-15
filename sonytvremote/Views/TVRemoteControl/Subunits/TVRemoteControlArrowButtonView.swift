//
//  TVRemoteControlArrowButtonView.swift
//  TV Remote
//
//  Created by Maksim Rudik on 6/14/22.
//

import SwiftUI

struct TVRemoteControlArrowButtonView: View {
    let dimension: TVButtonDimension
    let rotationAngle: Double
    let systemImage: String
    let clickAction: () -> Void
    
    var body: some View {
        Rectangle()
            .frame(
                width: dimension.arcFrame,
                height: dimension.arcFrame,
                alignment: .topLeading
            )
            .foregroundColor(.clear)
            .overlay {
                Button(action: clickAction) {
                    TVRemoteControlCenterViewArc(arcRadius: dimension.arcRadius)
                        .rotation(Angle(degrees: rotationAngle))
                        .stroke(
                            Theme.remoteButtonPrimaryColor,
                            lineWidth: dimension.arcLineWidth
                        )
                }
                Image(systemName: systemImage)
            }
    }
}

struct TVRemoteControlArrowButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TVRemoteControlArrowButtonView(
            dimension: TVButtonDimension(),
            rotationAngle: 180,
            systemImage: "arrow.up.left",
            clickAction: {}
        )
    }
}
