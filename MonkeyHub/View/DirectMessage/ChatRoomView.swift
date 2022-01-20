//
//  DirectConversationView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 7.09.2021.
//

import SwiftUI

struct ChatRoomView: View {

    @State var messageText = ""
    @ObservedObject var viewmodel: DMViewModel

    init(chatRoom: ChatRoom) {
        self.viewmodel = DMViewModel(chatRoom: chatRoom)

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

            // message inputview
            KeyboardInputView(text: $messageText, action: uploadMessage)

        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }

    func uploadMessage() {
        viewmodel.uploadDirectMessages(messageText: messageText)
        messageText = ""
    }

}

// struct ChatRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectConversationView()
//    }
// }
