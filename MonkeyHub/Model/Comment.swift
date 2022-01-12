//
//  Comment.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 28.05.2021.
//

import FirebaseFirestoreSwift
import Firebase

struct Comment: Identifiable, Decodable {

    @DocumentID var id: String?
    let username: String
    let postOwnerUID: String
    let profileImageURL: String
    let commentText: String
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
