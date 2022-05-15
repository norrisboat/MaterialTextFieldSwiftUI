# MaterialTextFieldSwiftUI

  

MaterialTextFieldSwiftUI is a UI library that is built to mimic [Material TextField](https://material.io/components/text-fields/android#using-text-fields) offered by Google. It's easy to integrate and comes with some useful customizations to help in many use cases.
If you like the project, please do not forget to **star ★** this repository and follow me on GitHub.

[![Platforms](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS-blue?style=flat-square)](https://developer.apple.com/macOS)
[![iOS](https://img.shields.io/badge/iOS-15.0-blue.svg)](https://developer.apple.com/iOS)
[![twitter](https://img.shields.io/badge/twitter-@norrisboat-orange.svg?style=flat-square)](https://www.instagram.com/dev.fabula)
[![SPM](https://img.shields.io/badge/SPM-compatible-red?style=flat-square)](https://developer.apple.com/documentation/swift_packages/package/)
[![MIT](https://img.shields.io/badge/licenses-MIT-red.svg)](https://opensource.org/licenses/MIT)  


## 📦 Requirements

- iOS 15.0+
- Xcode 11.2+
- Swift 5.0

##  📸 Demo

The Example application shows how to use all the customization options available.

![Demo](https://github.com/norrisboat/MaterialTextFieldSwiftUI/blob/main/Media/demo.gif)

## 💾 Installation

The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler. Once you have your Swift package set up, adding MaterialTextFieldSwiftUI as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```swift
dependencies: [
    .package(url: "https://github.com/norrisboat/MaterialTextFieldSwiftUI.git", .branch("main"))
]
```

## 💻 Usages

```swift
struct ContentView: View {
    
    @State private var isPasswordValid: Bool = false
    @State private var password: String = ""
    @State private var isSecure: Bool = false
    
    var body: some View {
        MaterialTextField($password, placeholder: "Enter password", isValid: $isPasswordValid)
            .isSecure(isSecure)
            .accentColor(.purple)
            .addValidations([RequiredValidator(errorMessage: "Please enter your password")])
            .rightView {
                Image(systemName: isPasswordShow ? "eye.fill" : "eye.slash.fill")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        isSecure.toggle()
                    }
            }
    }
}
```

![Password Demo](https://github.com/norrisboat/MaterialTextFieldSwiftUI/blob/main/Media/password-sample.gif)

### ⚙️ Customizations

| Extension                       | Description                                                  |
| ------------------------------- | ------------------------------------------------------------ |
| .contentType(.email)            | Content type of the input. It helps determine which keyboard type to show |
| .accentColor(.purple)           | Sets the color to show when the text field is active and the cursor color |
| .addValidations([validators])   | Sets an array validations conditions                         |
| .showError(true)                | Sets the condition to show the error view                    |
| .helperText("Some helper text") | Sets the helper text                                         |
| .isSecure(true)                 | Sets if input should be hidden                               |
| .isDisabled(false)              | Sets if the MaterialTextField is disabled                    |
| .maxCharacterCount(20)          | Sets the maximum character count to be accepted              |
| .showCharacterCounter(true)     | Sets if the character counter view should show               |
| .leftView(AnyView())            | Sets the left view                                           |
| .rightView(AnyView())           | Sets the right view                                          |



### 📘 Manual

You can download the latest files from our [Releases page](https://github.com/norrisboat/MaterialTextFieldSwiftUI/releases). After doing so, copy the files in the `Sources` folder to your project.


## 🙋🏻‍♂️ Author

[![twitter](https://img.shields.io/badge/twitter-@norrisboat-orange.svg?style=flat-square)](https://twitter.com/norrisboat)

## 💰 Contribution

Feel free to fork the project and send me a pull-request! 

## 📝 Feedback

Please file an [Issue](https://github.com/norrisboat/MaterialTextFieldSwiftUI/issues).

## 📜 License

MaterialTextFieldSwiftUI is available under the MIT license. See the LICENSE file for more info.
