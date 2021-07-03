//
//  KeyboardInputView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 29.05.2021.
//

import SwiftUI

struct KeyboardInputView: View {
    
    @Binding var text: String
    
    var action: () -> Void
    
    
    var body: some View {
        
        
        
        VStack {
            
            //divider line
            
//            Divider()
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
                .padding(.bottom, 8)
            
            //hstack with send button and textfield
            HStack {
                TextField("Comment...", text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                
                
                Button(action: {
                    
                        action()
                    
                }, label: {
                    Text("Send")
                        .bold()
                        .foregroundColor(.pink)
                })
                
            }
            .padding(.bottom)
            .padding(.horizontal)
            
        }
    }
}

struct KeyboardInputView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardInputView(text: .constant("hm"), action: testFunction)
    }
}

func testFunction() {
    
}
