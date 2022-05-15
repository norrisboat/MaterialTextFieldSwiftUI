//
//  ContentView.swift
//  MaterialTextFieldSwiftUIExample
//
//  Created by Norris Aboagye on 15/05/2022.
//

import SwiftUI
import MaterialTextFieldSwiftUI

struct ContentView: View {
    
    @State private var basicText: String = ""
    @State private var disabled: String = ""
    @State private var helperText: String = ""
    @State private var icons: String = ""
    @State private var textCounter: String = ""
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    
    @State private var isPasswordShow: Bool = false
    
    @State private var isEmailValid: Bool = false
    @State private var isPasswordValid: Bool = false
    @State private var isFullNameValid: Bool = false
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                Group {
                    Text("Basic")
                        .font(.title2)
                        .foregroundColor(.purple)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    MaterialTextField($basicText, placeholder: "First Name")
                    
                    MaterialTextField($basicText, placeholder: "Last name", style: .outlined)
                
                Text("Validation")
                    .font(.title2)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                
                MaterialTextField($email, placeholder: "Email address", isValid: $isEmailValid)
                    .contentType(.email)
                    .accentColor(.purple)
                    .addValidations([RequiredValidator(errorMessage: "Please enter your password"), EmailValidator()])
                    .autocapitalization(.none)
                
                MaterialTextField($password, placeholder: "Enter password", isValid: $isPasswordValid)
                    .isSecure(!isPasswordShow)
                    .accentColor(.purple)
                    .addValidations([RequiredValidator(errorMessage: "Please enter your password")])
                    .rightView {
                        Image(systemName: isPasswordShow ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(.gray)
                            .onTapGesture {
                                isPasswordShow.toggle()
                            }
                    }
                    
                    MaterialTextField($fullName, placeholder: "Fullname", isValid: $isFullNameValid, style: .outlined)
                        .accentColor(.purple)
                        .addValidations([RequiredValidator(errorMessage: "Please enter your full name")])
                    
                
                    Text("Input is \(isEmailValid && isPasswordValid && isFullNameValid ? "Valid" : "Invalid")")
                    
                }
                
                Group {
                Text("💻  Icons")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                
                MaterialTextField($icons, placeholder: "Date Picker")
                    .accentColor(.red)
                    .leftView {
                        Image(systemName: "calendar")
                            .foregroundColor(.red)
                    }
                    .rightView {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.yellow)
                    }
                
                MaterialTextField($icons, placeholder: "Clear text", style: .outlined)
                    .accentColor(.yellow)
                    .rightView {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .onTapGesture {
                                icons = ""
                            }
                    }
                
                Text("Disabled")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 16)
                
                MaterialTextField($disabled, placeholder: "Disabled")
                    .isDisabled(true)
                
                MaterialTextField($disabled, placeholder: "Disabled", style: .outlined)
                    .isDisabled(true)
                    
                }
                
                Group {
                    
                    Text("Helper Text")
                        .font(.title2)
                        .foregroundColor(.yellow)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 16)
                    
                    MaterialTextField($helperText, placeholder: "Helper Text")
                        .helperText("This is to give more information")
                    
                    MaterialTextField($helperText, placeholder: "Helper Text", style: .outlined)
                        .helperText("This is to give more information")
                }
                
                
                Group {
                    
                    Text("Text counter")
                        .font(.title2)
                        .foregroundColor(.indigo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 16)
                    
                    MaterialTextField($textCounter, placeholder: "Text Counter")
                        .maxCharacterCount(20)
                        .showCharacterCounter(true)
                    
                    MaterialTextField($textCounter, placeholder: "Text Counter", style: .outlined)
                        .maxCharacterCount(20)
                        .showCharacterCounter(true)
                    
                }
                
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
