//
//  SheetHeight.swift
//  Created by Casper Zandbergen on 17/10/2019.
//
import SwiftUI
import UIKit

extension View {
    /// Presents a sheet.
    ///
    /// - Parameters:
    ///     - height: The height of the presented sheet.
    ///     - item: A `Binding` to an optional source of truth for the sheet.
    ///     When representing a non-nil item, the system uses `content` to
    ///     create a sheet representation of the item.
    ///
    ///     If the identity changes, the system will dismiss a
    ///     currently-presented sheet and replace it by a new sheet.
    ///
    ///     - onDismiss: A closure executed when the sheet dismisses.
    ///     - content: A closure returning the content of the sheet.
    public func sheet<Item: Identifiable, Content: View>(height: SheetHeight, item: Binding<Item?>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        self.sheet(item: item, onDismiss: onDismiss) { item in
            SheetView(height: height, content: { content(item) })
        }
    }
    
    /// Presents a sheet.
    ///
    /// - Parameters:
    ///     - height: The height of the presented sheet.
    ///     - isPresented: A `Binding` to whether the sheet is presented.
    ///     - onDismiss: A closure executed when the sheet dismisses.
    ///     - content: A closure returning the content of the sheet.
    public func sheet<Content: View>(height: SheetHeight, isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.sheet(isPresented: isPresented, onDismiss: onDismiss) {
            SheetView(height: height, content: content)
        }
    }
}

public enum SheetHeight {
    case points(CGFloat)
    case percentage(CGFloat)
    /// When the provided content's height can be infered it will show up as that. ScrollView and List don't have this by default so they will show as 50%. You can use .frame(height:) to change that.
    case infered
    
    fileprivate func emptySpaceHeight(in size: CGSize) -> CGFloat? {
        switch self {
        case .points(let height):
            let remaining = size.height - height
            return max(remaining, 0)
        case .percentage(let percentage):
            precondition(0...100 ~= percentage)
            let remaining = 100 - percentage
            return size.height / 100 * remaining
        case .infered:
            return nil
        }
    }
}

private struct SheetView<Content: View>: View {
    var height: SheetHeight
    var content: () -> Content
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ParentInvisible {
            GeometryReader { geometry in
                VStack {
                    Spacer(minLength: self.height.emptySpaceHeight(in: geometry.size)).onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    ZStack(alignment: .bottom) {
                        SafeAreaFillView(geometry: geometry)
                        self.content().clipShape(SheetShape(geometry: geometry))
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

private struct SafeAreaFillView: View {
    var geometry: GeometryProxy
    
    var body: some View {
        Color(.systemBackground)
            .frame(width: geometry.size.width, height: geometry.safeAreaInsets.bottom)
            .offset(y: geometry.safeAreaInsets.bottom)
    }
}

private struct ParentInvisible<Content: View>: UIViewControllerRepresentable {
    var content: () -> Content
    
    func makeUIViewController(context: Context) -> UIHostingController<Content> {
        let host = UIHostingController(rootView: content())
        host.view.backgroundColor = .clear
        return host
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: Context) {
        uiViewController.parent?.view.backgroundColor = .clear
    }
}

private struct SheetShape: Shape {
    var geometry: GeometryProxy
    let radius = 8

    func path(in rect: CGRect) -> Path {
        var rect = rect
        rect.size.height += geometry.safeAreaInsets.bottom
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension Spacer {
    /// https://stackoverflow.com/a/57416760/3393964
    public func onTapGesture(count: Int = 1, perform action: @escaping () -> Void) -> some View {
        ZStack {
            Color.black.opacity(0.001).onTapGesture(count: count, perform: action)
            self
        }
    }
}
