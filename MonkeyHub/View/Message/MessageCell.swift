//
//  MessageCell.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 3.07.2021.
//

import SwiftUI
import Kingfisher

struct MessageCell: View {

    let message: Message

    var body: some View {
        HStack {

            KFImage(URL(string: message.profileImageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())

            Text("\(message.username)")
                .font(.system(size: 14, weight: .semibold)) +
                Text(" \(message.messageText)")
                .font(.system(size: 14))

            Spacer()
            Text(" \(message.timestampString ?? "")")
                .foregroundColor(.gray)
                .font(.system(size: 12))

        }
        .padding(.horizontal)
    }
}

// struct MessageCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageCell()
//    }
// }
