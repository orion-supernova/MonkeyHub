//
//  DirectConversationCell.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 7.09.2021.
//

import SwiftUI
import Kingfisher

struct DirectMessageCell: View {
    
    let dmMessage: DmMessage
    
    var body: some View {
        HStack {
            
            KFImage(URL(string: dmMessage.profileImageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            Text("\(dmMessage.username)")
                .font(.system(size: 14, weight: .semibold)) +
                Text(" \(dmMessage.messageText)")
                .font(.system(size: 14))
            
            Spacer()
            Text(" \(dmMessage.timestampString ?? "")")
                .foregroundColor(.gray)
                .font(.system(size: 12))
                
        }
        .padding(.horizontal)
    }
}
