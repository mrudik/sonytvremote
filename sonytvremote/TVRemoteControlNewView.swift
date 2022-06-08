//
//  TVRemoteControlNewView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/27/22.
//

import SwiftUI

struct TVRemoteControlNewView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.title)
                Text("Content")
                    .font(.body)
            }
        }
        .frame(
            maxWidth: 380,
            maxHeight: 840,
            alignment: .bottom
        )
        .background(Color.red)
    }
}

struct TVRemoteControlNewView_Previews: PreviewProvider {
    static var previews: some View {
        TVRemoteControlNewView()
    }
}
