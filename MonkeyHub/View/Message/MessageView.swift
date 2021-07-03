//
//  MessageView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 3.07.2021.
//

import SwiftUI

struct MessageView: View {
    
    @State var messageText = ""
    @ObservedObject var viewmodel: MessageViewModel
    
    
    init(toUser: User) {
        self.viewmodel = MessageViewModel(toUser: toUser)
    }
    
    var body: some View {
        VStack {
            
            // comment cells
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewmodel.messages) { message in
                        MessageCell(message: message)
                        
                        
                        
                    }
                }
            }
            .padding(.top)
            
            //message inputview
            KeyboardInputView(text: $messageText, action: uploadMessage)
            
            
        }
    }
    
    func uploadMessage() {
        
    }
    
    
}

//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView()
//    }
//}

