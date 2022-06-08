//
//  TVDeviceCellView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/24/22.
//

import SwiftUI

struct TVDeviceCellView: View {
    let device: TVDevice
    
    var body: some View {
        HStack {
            Image(systemName: "tv")
                .font(.title)
            
            VStack(alignment: .leading) {
                Text(device.name)
                    .font(.title)
                
                Text(device.location)
                    .foregroundColor(Color.gray)
            }
            .padding(.leading)
        }
        .padding()
    }
}

struct TVDeviceCellView_Previews: PreviewProvider {
    static var sampleDevice = TVDevice.sampleDeviceList[0]
    static var previews: some View {
        TVDeviceCellView(device: sampleDevice)
            .previewLayout(.fixed(width: 400, height: 60))
            .environment(\.colorScheme, .dark)
    }
}
