//
//  File.swift
//  
//
//  Created by Norris Aboagye on 15/05/2022.
//

import SwiftUI

extension TextField {
    func adaptiveKeyboardType(type contentType: ContentType) -> some View {
        self.modifier(AdaptiveKeyboardTypeModifier(contentType: contentType))
    }
}

extension SecureField {
    func adaptiveKeyboardType(type contentType: ContentType) -> some View {
        self.modifier(AdaptiveKeyboardTypeModifier(contentType: contentType))
    }
}

struct AdaptiveKeyboardTypeModifier: ViewModifier {
    @State var contentType: ContentType
    init(contentType: ContentType) {
        self._contentType = .init(initialValue: contentType)
    }
    func body(content: Content) -> some View {
        var keyboardType: UIKeyboardType = .default
        switch contentType {
        case .email: keyboardType = .emailAddress
        case .name: keyboardType = .namePhonePad
        case .none: keyboardType = .default
        case .number: keyboardType = .numberPad
        case .phone: keyboardType = .numberPad
        }
        return content.keyboardType(keyboardType)
    }
}

struct RoundedCornersShape: Shape {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
