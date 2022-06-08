//
//  TVRemoteControlCenterViewArc.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/24/22.
//

import SwiftUI

struct TVRemoteControlCenterViewArc: Shape {
    let buttonIndex: Int
    let totalButtons: Int = 4
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 100.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        return Path { path in
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
        }
    }
    
    private var degreesPerButton: Double {
        360.0 / Double(totalButtons)
    }
    
    private var startAngle: Angle {
        // The additional 1.0 degree is for visual separation between arc segments
        Angle(degrees: degreesPerButton * Double(buttonIndex) + 3.0)
    }
    
    private var endAngle: Angle {
        // The substructed 1.0 degree is for visual separation between arc segments
        Angle(degrees: startAngle.degrees + degreesPerButton - 3.0)
    }
}
