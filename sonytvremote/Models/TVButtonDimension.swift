//
//  TVButtonDimension.swift
//  TV Remote
//
//  Created by Maksim Rudik on 6/14/22.
//

import SwiftUI

/*
 Viewport width of
 ipod touch: 320
 iphone 12 mini: 360
 iphone 8:375
 iphone 11: 414
 iphone 13 pro max: 428
 */

struct TVButtonDimension {
    var viewPortWidth: CGFloat = 428
    var outerCircleFrame: CGFloat = 354
    var arcFrame: CGFloat = 175
    var arcLineWidth: CGFloat = 100
    var arcRadius: CGFloat = 130
    var innerCircleDiameter: CGFloat = 156
    var innerCircleShadowDiameter: CGFloat = 150
    var spacing: CGFloat = 4
    var powerOffDiameter: CGFloat = 80
    
    init() {
        let deviceViewPortWidth = UIScreen.main.bounds.width
        
        self.outerCircleFrame = deviceViewPortWidth * outerCircleFrame / viewPortWidth
        self.arcFrame = deviceViewPortWidth * arcFrame / viewPortWidth
        self.arcLineWidth = deviceViewPortWidth * arcLineWidth / viewPortWidth
        self.arcRadius = deviceViewPortWidth * arcRadius / viewPortWidth
        self.innerCircleDiameter = deviceViewPortWidth * innerCircleDiameter / viewPortWidth
        self.innerCircleShadowDiameter = deviceViewPortWidth * innerCircleShadowDiameter / viewPortWidth
        self.spacing = viewPortWidth * spacing / viewPortWidth
        self.powerOffDiameter = deviceViewPortWidth * powerOffDiameter / viewPortWidth
    }
}
