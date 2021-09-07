//
//  DirectConversationView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 7.09.2021.
//

import SwiftUI

struct DirectConversationView: View {
    
    @State var messageText = ""
    @ObservedObject var viewmodel: DirectMessageViewModel
    
    
    init(dmConversation: DmConversation) {
        self.viewmodel = DirectMessageViewModel(dmConversation: dmConversation)
    }
    
    var body: some View {
        VStack {
            
            // comment cells
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
                    ForEach(viewmodel.dmMessages) { message in
                        DirectMessageCell(dmMessage: message)
                    }
                }
            }
            .padding(.top)
            
            //message inputview
            KeyboardInputView(text: $messageText, action: uploadMessage)
            
            
        }
    }
    
    func uploadMessage() {
        viewmodel.uploadDirectMessages(messageText: messageText)
        messageText = ""
    }
    
    
}

//struct DirectConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectConversationView()
//    }
//}
