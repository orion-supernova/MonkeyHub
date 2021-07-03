//
//  UserCell.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 24.05.2021.
//

import SwiftUI
import Kingfisher

struct UserCell: View {
    
    let user: User
    
    var body: some View {
        HStack {
            //image
            KFImage(URL(string: user.profileImageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 48, height: 48)
                .cornerRadius(24)
            
            //vstack -> username, fullname
            VStack (alignment: .leading) {
                Text(user.username)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(user.fullname)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

//
//struct UserCell_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCell()
//    }
//}
