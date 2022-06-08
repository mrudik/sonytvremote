//
//  TVDetailsView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/24/22.
//

import SwiftUI

struct TVDetailsView: View {
    @Binding var devices: [TVDevice]
    @Binding var data: TVDevice.Data
    @Environment(\.presentationMode) var presentation
    
    @State private var isRemoveAlertDisplayed = false
    
    @State private var isEditMode = false
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Image(systemName: "tv")
                        .font(.system(size: 64))
                }
                .listRowInsets(EdgeInsets())
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .foregroundColor(.gray)
                .background(Theme.backgroundColor)
                
                Section(header: Text("TV device information")) {
                    TextField("Name", text: $data.name)
                        .onChange(of: data.name) {newValue in
                            data.validate()
                        }
                    TextField("Location", text: $data.location)
                        .onChange(of: data.location) {newValue in
                            data.validate()
                        }
                    TextField("IP Address", text: $data.ipAddress)
                        .onChange(of: data.ipAddress) {newValue in
                            data.validate()
                        }
                    TextField("Pre-Shared Key", text: $data.presharedKey)
                        .onChange(of: data.presharedKey) {newValue in
                            data.validate()
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("IP Address and Pre-Shared Key can be found on your Sony TV. \n\nIP Address:\nGo to Settings → Network & Internet → Network status. \n\nPre-Shared Key:\nGo to Settings → Network & Internet → Home network → IP control → Pre-Shared Key.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing, .bottom])
                    
                    Divider()
                    
                    Text("Important:\nYou must be on the same Wi-Fi network as your TV device in order to control it.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing, .top])
                }
                .listRowInsets(EdgeInsets())
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .foregroundColor(.gray)
                .background(Theme.backgroundColor)
            }
            
            if isEditMode {
                Button("Remove this TV", role: .destructive) {
                    isRemoveAlertDisplayed = true
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .foregroundColor(.white)
            }
        }
        .background(Theme.backgroundColor)
        .navigationTitle(isEditMode ? "Update a TV" : "Add a TV")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $isRemoveAlertDisplayed) {
            Alert(
                title: Text("Are you sure?"),
                message: Text("By deleting this device you will no longer be able to control it."),
                primaryButton: .destructive(Text("Remove")) {
                    isRemoveAlertDisplayed = false
                    devices.removeDeviceById(id: data.deviceId)
                    self.presentation.wrappedValue.dismiss()
                },
                secondaryButton: .default(Text("Cancel")) {
                    isRemoveAlertDisplayed = false
                }
            )
        }
        .onAppear {
            data.validate()
            isEditMode = data.isAnyDataPresent()
        }
    }
}

struct TVDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TVDetailsView(
            devices: .constant(TVDevice.sampleDeviceList),
            data: .constant(TVDevice.sampleDeviceList[0].data)
        )
        //.environment(\.colorScheme, .dark)
    }
}
