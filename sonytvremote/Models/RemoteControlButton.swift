//
//  RemoteControlButton.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/25/22.
//

import Foundation

enum RemoteControlButton: String {
    case actionUp
    case actionDown
    case actionLeft
    case actionRight
    case actionConfirm
    case actionPictureOff
    case actionHome
    case actionBack
    case actionPower
    case actionVolumeUp
    case actionVolumeDown
    case actionMute
    case actionInput
    case actionSubTitle
    case actionPrev
    case actionNext
    case actionPlay
    case actionPause
    
    var name: String {
        rawValue
    }
    
    var IRCCCode: String {
        switch self {
        case .actionUp:
            return "AAAAAQAAAAEAAAB0Aw=="
        case .actionDown:
            return "AAAAAQAAAAEAAAB1Aw=="
        case .actionLeft:
            return "AAAAAQAAAAEAAAA0Aw=="
        case .actionRight:
            return "AAAAAQAAAAEAAAAzAw=="
        case .actionConfirm:
            return "AAAAAQAAAAEAAABlAw=="
        case .actionPictureOff:
            return "AAAAAQAAAAEAAAA+Aw=="
        case .actionHome:
            return "AAAAAQAAAAEAAABgAw=="
        case .actionBack:
            return "AAAAAgAAAJcAAAAjAw=="
        case .actionPower:
            return "AAAAAQAAAAEAAAAVAw=="
        case .actionVolumeUp:
            return "AAAAAQAAAAEAAAASAw=="
        case .actionVolumeDown:
            return "AAAAAQAAAAEAAAATAw=="
        case .actionMute:
            return "AAAAAQAAAAEAAAAUAw=="
        case .actionInput:
            return "AAAAAQAAAAEAAAAlAw=="
        case .actionSubTitle:
            return "AAAAAgAAAJcAAAAoAw=="
        case .actionPrev:
            return "AAAAAgAAAJcAAAA8Aw=="
        case .actionNext:
            return "AAAAAgAAAJcAAAA9Aw=="
        case .actionPlay:
            return "AAAAAgAAAJcAAAAaAw=="
        case .actionPause:
            return "AAAAAgAAAJcAAAAZAw=="
        }
    }
}
