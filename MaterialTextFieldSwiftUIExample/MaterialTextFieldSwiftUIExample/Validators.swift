//
//  Validators.swift
//  MaterialTextFieldSwiftUIExample
//
//  Created by Norris Aboagye on 15/05/2022.
//

import Foundation
import MaterialTextFieldSwiftUI


struct RequiredValidator: MaterialtextFieldValidator {
    var errorMessage: String
    
    init(errorMessage: String =  "Field is required") {
        self.errorMessage = errorMessage
    }
    
    public func isValid(content: String) -> Bool {
        return content.isNotBlank
    }
    
    public func getError() -> String {
        return errorMessage
    }
}

public struct EmailValidator: MaterialtextFieldValidator {
    var errorMessage: String
    
    init(errorMessage: String =  "Invalid Email") {
        self.errorMessage = errorMessage
    }
    
    public func isValid(content: String) -> Bool {
        return content.isEmail
    }
    
    public func getError() -> String {
        return errorMessage
    }
    
}

extension String {
    
    //Validate Email
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    var isNotBlank: Bool {
        get {
            return !self.isBlank
        }
    }
}
