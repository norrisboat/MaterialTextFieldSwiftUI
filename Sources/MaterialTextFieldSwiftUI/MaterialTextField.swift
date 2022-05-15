//
//  MaterialTextField.swift
//  
//
//  Created by Norris Aboagye on 15/05/2022.
//

import SwiftUI

/// A view mimicing the material text view provided by Google with various customizations
public struct MaterialTextField: View {
    
    @Binding private var content: String
    @Binding private var isValid: Bool
    @State private var isFilled: Bool = false
    @State private var isFocused: Bool = false
    @State private var showError: Bool = false
    @State private var error: String = ""
    @FocusState private var isTextFieldFocused: Bool
    
    @ObservedObject private var notifier = MaterialTextFieldNotifier()
    
    var placeholder: String = ""
    var style: MaterialTextFieldStyle
    
    /// Show a Material Text Field with default parameters
    /// - Parameters:
    ///   - content: Text content
    ///   - placeholder: Hint to give the user an idea of what to input
    ///   - isValid: A Binding to indicate if the input is valid
    ///   - style: The style of the text field. Default is normal
    public init(_ content: Binding<String>, placeholder: String, isValid: Binding<Bool>? = nil, style: MaterialTextFieldStyle = .normal) {
        self._content = content
        self._isValid = isValid ?? .constant(true)
        self.placeholder = placeholder
        self.style = style
    }
    
    public var body: some View {
        VStack(spacing: 0){
            ZStack {
                background()
                
                HStack{
                    
                    notifier.leftView
                    
                    contentView()
                    
                    notifier.rightView
                }
                .padding(.leading, 8)
                .padding(.trailing, 8)
                .padding(.bottom, 0)
            }
            
            bottomLine()
            
            HStack {
                if !notifier.helperText.isEmpty {
                    helperTextView()
                } else {
                    errorView()
                }
                if notifier.showCharacterCounter {
                    characterCounterTextView()
                }
            }
        }
    }
    
    //MARK: Content View
    func contentView() -> some View {
        ZStack {
            Text(placeholder)
                .foregroundColor(isFilled ? notifier.color : notifier.isDisabled ? .gray.opacity(0.5) : .gray)
                .padding(.trailing, isFilled && style == .outlined ? 5 : 0)
                .padding(.leading, isFilled && style == .outlined ? 5 : 0)
                .background(Rectangle().foregroundColor(isFilled && style == .outlined ? Color(UIColor.systemBackground) : .clear))
                .frame(maxWidth: .infinity, alignment: .leading)
                .scaleEffect(isFilled ? 0.6 : 1, anchor: .topLeading)
                .offset(x: 0, y: isFilled ? style == .outlined ? -24 : -12  : 0)
            
            if notifier.isSecure {
                SecureField("", text: $content.animation()) {
                    (isValid, error) = notifier.checkError(content: content)
                }
                .adaptiveKeyboardType(type: notifier.contentType)
                .accentColor(notifier.color)
                .disabled(notifier.isDisabled)
                .focused($isTextFieldFocused)
                .onChange(of: content) { newContent in
                    
                    if newContent.count > notifier.maxCharacters {
                        content = "\(newContent.dropLast(newContent.count - notifier.maxCharacters))"
                    }
                    
                    (isValid, error) = notifier.checkError(content: content)
                    
                    if(content == "") {
                        withAnimation(.easeOut(duration: 0.15)) {
                            isFilled = false
                        }
                    } else {
                        withAnimation(.easeIn(duration: 0.15)) {
                            isFilled = true
                        }
                    }
                }
                .onChange(of: isTextFieldFocused) { isFocused in
                    withAnimation() {
                        self.isFocused = isFocused
                    }
                }
            } else {
                
                TextField("", text: $content.animation()) {
                    (isValid, error) = notifier.checkError(content: content)
                }
                .adaptiveKeyboardType(type: notifier.contentType)
                .accentColor(notifier.color)
                .disabled(notifier.isDisabled)
                .focused($isTextFieldFocused)
                .onChange(of: content) { newContent in
                    
                    if newContent.count > notifier.maxCharacters {
                        content = "\(newContent.dropLast(newContent.count - notifier.maxCharacters))"
                    }
                    
                    (isValid, error) = notifier.checkError(content: content)
                    
                    if(content == "") {
                        withAnimation(.easeOut(duration: 0.15)) {
                            isFilled = false
                        }
                    } else {
                        withAnimation(.easeIn(duration: 0.15)) {
                            isFilled = true
                        }
                    }
                }
                .onChange(of: isTextFieldFocused) { isFocused in
                    withAnimation() {
                        self.isFocused = isFocused
                    }
                }
            }
        }
    }
    
    //MARK: Bottom Line
    @ViewBuilder
    func bottomLine() -> some View {
        switch style {
        case .normal:
            Rectangle().frame(height: isFocused ? 2 : 0.5).cornerRadius(2).padding(.top, 5).foregroundColor(isFocused ? notifier.color : .gray)
        case .outlined:
            EmptyView()
        }
    }
    
    //MARK: Error View
    func errorView() -> some View {
        Text(error)
            .foregroundColor(.red)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8)
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.trailing, 8)
    }
    
    //MARK: Helper Text View
    func helperTextView() -> some View {
        Text(notifier.helperText)
            .foregroundColor(.gray)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 8)
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.trailing, 8)
    }
    
    //MARK: Character Count View
    func characterCounterTextView() -> some View {
        Text(content.isEmpty ? "" : String.init(format: "%d/%d", content.count, notifier.maxCharacters))
            .foregroundColor(.gray)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.leading, 8)
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.trailing, 8)
    }
    
    //MARK: Background View
    @ViewBuilder
    func background() -> some View {
        switch style {
        case .normal:
            RoundedCornersShape(corners: [.topLeft, .topRight], radius: 5)
                .fill(.gray.opacity(0.1))
                .frame(height: 55)
                .padding(.bottom, -6)
                .padding(.top, -6)
        case .outlined:
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder()
                .foregroundColor(notifier.isDisabled ? .gray.opacity(0.5) : isFocused ? notifier.color : .gray)
                .frame(height: 55)
        }
    }
    
    func clear() {
        self.content = ""
    }
}

//MARK: Extensions
public extension MaterialTextField {
    
    /// Content type of the input. It helps determine which keyboard type to show
    /// - Parameter contentType: Content type of the input
    /// - Returns: MaterialTextField
    func contentType(_ contentType: ContentType) -> Self{
        notifier.contentType = contentType
        return self
    }
    
    /// Sets the color to show when the text field is active and the cursor color
    /// - Parameter color: Accent color
    /// - Returns: MaterialTextField
    func accentColor(_ color: Color) -> Self{
        notifier.color = color
        return self
    }
    
    /// Sets the validations conditions
    /// - Parameter validators: Array of validations
    /// - Returns: MaterialTextField
    func addValidations(_ validators: [MaterialtextFieldValidator]) -> Self {
        notifier.validators.append(contentsOf: validators)
        showError = true
        return self
    }
    
    /// Sets the condition to show the error view
    /// - Parameter show: Boolean state to enable or disable showing an error
    /// - Returns: MaterialTextField
    func showError(_ show: Bool) -> Self {
        showError = show
        return self
    }
    
    /// Sets the helper text
    /// - Parameter text: The helper text
    /// - Returns: MaterialTextField
    func helperText(_ text: String) -> Self {
        notifier.helperText = text
        return self
    }
    
    /// Sets if the MaterialTextField is secure
    /// - Parameter isSecure: Boolean state to enable or disable secure text input
    /// - Returns: MaterialTextField
    func isSecure(_ isSecure: Bool) -> Self {
        notifier.isSecure = isSecure
        return self
    }
    
    /// Sets if the MaterialTextField is disabled
    /// - Parameter isDisabled: Boolean state to enable or disable MaterialTextField
    /// - Returns: MaterialTextField
    func isDisabled(_ isDisabled: Bool) -> Self {
        notifier.isDisabled = isDisabled
        return self
    }
    
    
    /// Sets the maximum character count to be accepted
    /// - Parameter max: The maximum character count
    /// - Returns: MaterialTextField
    func maxCharacterCount(_ max: Int) -> Self {
        notifier.maxCharacters = max
        return self
    }
    
    /// Sets if the character counter view should show or not
    /// - Parameter show: Boolean state to show character count or not
    /// - Returns: MaterialTextField
    func showCharacterCounter(_ show: Bool) -> Self {
        notifier.showCharacterCounter = show
        return self
    }
    
    /// Sets the left view
    /// - Parameter view:  A view that will be shown on the leading side of the MaterialTextField
    /// - Returns: MaterialTextField
    func leftView<LeftView: View>(@ViewBuilder _ view: @escaping () -> LeftView) -> Self {
        notifier.leftView = AnyView(view())
        return self
    }
    
    /// Sets the right view
    /// - Parameter view:  A view that will be shown on the trailing side of the MaterialTextField
    /// - Returns: MaterialTextField
    func rightView<RightView: View>(@ViewBuilder _ view: @escaping () -> RightView) -> Self {
        notifier.rightView = AnyView(view())
        return self
    }
}
