//
//  TVSettingsCellView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/26/22.
//

import SwiftUI

struct TVSettingsCellView: View {
    var body: some View {
        HStack {
            //Image(systemName: "gearshape")
            //    .font(.title3)
            
            Text("Settings")
                .font(.title3)
                //.padding(.leading)
        }
        .padding([.leading, .trailing])
    }
}

struct TVSettingsCellView_Previews: PreviewProvider {
    static var previews: some View {
        TVSettingsCellView()
            
    }
}
