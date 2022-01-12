//
//  DmUser.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 7.09.2021.
//

import FirebaseFirestoreSwift
import Firebase

struct DmMessage: Identifiable, Decodable {

    @DocumentID var id: String?
    let username: String
    let dmCreatorUID: String
    let profileImageURL: String
    let messageText: String
    let timestamp: Timestamp
    let uid: String

    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }

}
