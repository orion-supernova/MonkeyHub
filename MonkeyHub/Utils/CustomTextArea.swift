//
//  CustomTextArea.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 26.05.2021.
//

import SwiftUI

struct CustomTextArea: View {
    
    @Binding var text: String
    let placeholder: String
    
    
    init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            TextEditor(text: $text)
                .padding(4)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .font(.body)
    }
}

//struct CustomTextArea_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextArea(text: .constant("hm"), placeholder: "oke")
//    }
//}
