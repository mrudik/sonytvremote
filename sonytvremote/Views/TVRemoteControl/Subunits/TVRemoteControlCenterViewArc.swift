//
//  TVRemoteControlCenterViewArc.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/26/22.
//

import SwiftUI

struct TVRemoteControlCenterViewArc: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.addArc(
                center: CGPoint(x: 0, y: 0),
                radius: 130,
                startAngle: Angle(degrees: 0.0),
                endAngle: Angle(degrees: 90.0),
                clockwise: false
            )
        }
    }
}
