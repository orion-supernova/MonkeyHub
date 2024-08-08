//
//  Message.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 3.07.2021.
//

import FirebaseFirestore
import Firebase

struct Message: Identifiable, Codable {

    @DocumentID var id: String?
    let username: String
    let senderUID: String
    let receiverUID: String
    let profileImageURL: String
    let text: String
    let timestamp: Timestamp
    let uid: String
    let received: Bool

    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue(), to: Date()) ?? ""
    }

}
