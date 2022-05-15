//
//  MaterialTextFieldUtils.swift
//  
//
//  Created by Norris Aboagye on 15/05/2022.
//

import Foundation
import SwiftUI

class MaterialTextFieldNotifier: ObservableObject {
    
    @Published var leftView: AnyView?
    @Published var rightView: AnyView?
    
    @Published var isSecure: Bool = false
    @Published var contentType: ContentType = .none
    @Published var color: Color = .blue
    @Published var isDisabled: Bool = false
    @Published var maxCharacters: Int = .max
    @Published var showCharacterCounter: Bool = false
    @Published var helperText: String = ""
    
    @Published var validators: [MaterialtextFieldValidator] = []
    
    /// Checks for any error and returns the status
    /// - Parameter content: current text of text field
    /// - Returns: false if there is no error or true with specific error
    func checkError(content: String) -> (Bool, String) {
        for validator in validators {
            if !validator.isValid(content: content) {
                return (false, validator.getError())
            }
        }
        return (true, "")
    }
}

public enum ContentType {
    case none
    case email
    case number
    case phone
    case name
}

public enum MaterialTextFieldStyle {
    case normal
    case outlined
}

public protocol MaterialtextFieldValidator {
    func isValid(content: String) -> Bool
    func getError() -> String
}

