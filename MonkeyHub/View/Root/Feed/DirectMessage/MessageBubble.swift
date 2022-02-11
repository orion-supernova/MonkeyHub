//
//  MessageBubble.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 21.01.2022.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    @State private var showTime = false

    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing ) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(.ultraThickMaterial)
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }

            if showTime {
                Text(message.timestampString ?? "")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.received ? .leading : .trailing, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(.horizontal)
    }
}
// swiftlint:disable all
//struct MessageBubble_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageBubble(message: Message(id: "12345", username: "Santa", senderUID: "12345", receiverUID: "12345", profileImageURL: "12345", text: "Ho ho ho Swift Rocks. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", timestamp: (Date())), uid: "12345", received: false)
//    }
//}
