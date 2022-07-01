//
//  TVRemoteView.swift
//  sonytvremote
//
//  Created by Maksim Rudik on 5/24/22.
//

import SwiftUI
import SheeKit

struct TVRemoteView: View {
    @Binding var devices: [TVDevice]
    @Binding var device: TVDevice
    
    @StateObject var remote = TVDeviceRemoteControl()
    @State private var data = TVDevice.Data()
    @State private var isPresentingTVDeviceEditView = false
    @State private var isPresentingExtendedControlsView = false
    @State private var selectedDetentIdentifier = UISheetPresentationController.Detent.Identifier.medium
    
    @State private var activeBtnTest = ""
    @State private var dimension = TVButtonDimension()
    
    var presentedViewControllerParameters: UIViewControllerProxy {
        var parameters = UIViewControllerProxy()
        parameters.preferredStatusBarStyle = .darkContent
        parameters.preferredStatusBarUpdateAnimation = .fade
        parameters.isModalInPresentation = true
        parameters.modalTransitionStyle = .flipHorizontal
        return parameters
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {remote.click(button: .actionPower)}) {
                    Circle()
                        .foregroundColor(Theme.remoteButtonSecondaryColor)
                        .frame(
                            width: dimension.powerOffDiameter,
                            height: dimension.powerOffDiameter,
                            alignment: .center
                        )
                        .shadow(radius: 5, x: 0, y: 5)
                        .overlay {
                            Image(systemName: "power")
                                .font(.title)
                                .foregroundColor(Theme.remoteButtonSecondaryTextColor)
                        }
                }
            }
            .padding()
            
            Spacer()
            
            TVRemoteControlCenterView(dimension: dimension) { buttonClicked in
                remote.click(button: buttonClicked)
            }
            
            Spacer()
            
            Button("More controls") {
                isPresentingExtendedControlsView = true
            }
            
            TVRemoteControlBottomView(dimension: dimension) { buttonClicked in
                remote.click(button: buttonClicked)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.backgroundColor)
        .foregroundColor(Theme.remoteButtonSecondaryColor)
        .toolbar {
            Button("Edit") {
                isPresentingTVDeviceEditView = true
                data = device.data
            }
        }
        .navigationTitle(device.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPresentingTVDeviceEditView) {
            NavigationView {
                TVDetailsView(devices: $devices, data: $data)
                    .navigationTitle(device.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingTVDeviceEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresentingTVDeviceEditView = false
                                device.update(from: data)
                            }
                            .tint(Theme.navBarConfirmationTextColor)
                            .disabled(data.areRequiredFieldsEmpty)
                        }
                    }
            }
        }
        .shee(
            isPresented: $isPresentingExtendedControlsView,
            presentationStyle: .formSheet(
                properties:.init(
                    detents: [.medium()],
                    animatesSelectedDetentIdentifierChange: true
                )
            )
        ) {
            NavigationView {
                TVRemoteControlExtendedView() { buttonClicked in
                    remote.click(button: buttonClicked)
                }
                .navigationTitle(device.name)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red.edgesIgnoringSafeArea(.all))
        
        
        /*
        .sheet(height: .points(600), isPresented: $isPresentingExtendedControlsView) {
            NavigationView {
                TVRemoteControlExtendedView() { buttonClicked in
                    remote.click(button: buttonClicked)
                }
                .navigationTitle(device.name)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
         */
        .sheet(isPresented: $remote.isErrorOccured) {
            ErrorView(errorWrapper: remote.errorWrapper!)
        }
        .onAppear {
            remote.bindTV(device: device)
        }
    }
}

struct TVRemoteView_Previews: PreviewProvider {
    static var previews: some View {
        TVRemoteView(
            devices: .constant(TVDevice.sampleDeviceList),
            device: .constant(TVDevice.sampleDeviceList[0])
        )
        .environment(\.colorScheme, .dark)
    }
}
