//
//  DirectConversationView.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 7.09.2021.
//

import SwiftUI
import Firebase

struct ChatRoomView: View {

    @State var messageText = ""
    @ObservedObject var viewmodel: DMViewModel

    init(chatRoom: ChatRoom) {
        self.viewmodel = DMViewModel(chatRoom: chatRoom)
    }
    var barbaraURL = URL(string: "https://instagram.fsaw1-15.fna.fbcdn.net/v/t51.2885-15/e35/141688253_771536940381147_408860329412683372_n.jpg?_nc_ht=instagram.fsaw1-15.fna.fbcdn.net&_nc_cat=103&_nc_ohc=aNmxI8xsOdkAX-vL1Aq&edm=ALQROFkBAAAA&ccb=7-4&ig_cache_key=MjQ5NDYyNDYzMDAwMTgxNzMyMw%3D%3D.2-ccb7-4&oh=00_AT87YTEQ3cJnCUs4maVSk3ZavSEXsm7eEz-R_yGcZLUxGA&oe=61F07501&_nc_sid=30a2ef")
    var dummnyMessageArray = ["Selam", "Ben Barbara", "Manken Olan", ":D?"]

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 24) {
//                    ForEach(viewmodel.messages) { message in
//                        MessageBubble(message: Message(id: message.id, username: message.username, senderUID: message.senderUID, receiverUID: message.receiverUID, profileImageURL: message.profileImageURL, text: message.text, timestamp: message.timestamp, uid: message.uid, received: message.received))
//                    }
                    ForEach(0..<dummnyMessageArray.count, id: \.self) { count in
                        MessageBubble(message: Message(id: "1234", username: "Barbara", senderUID: "1234", receiverUID: "1234", profileImageURL: "1234", text: "\(dummnyMessageArray[count])", timestamp: Timestamp(date: Date()), uid: "1234", received: count == 3 ? false : true))
                    }
                }
            }
            .padding(.top, 10)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        AsyncImage(url: barbaraURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                        }

                        Text("Barbara Palvin ❤️")
                    }
                }
            }

            // message inputview
            KeyboardInputView(text: $messageText, action: uploadMessage)

        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }

    func uploadMessage() {
    }

}

// struct ChatRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectConversationView()
//    }
// }
