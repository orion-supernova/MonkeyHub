//
//  UserService.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 26.05.2021.
//

import Firebase

typealias FirestoreCompletion = ((Error?) -> Void)?

struct UserService {

    static func follow(uid: String, completion: ((Error?) -> Void)?) {

        guard let currentUID = AuthViewModel.shared.userSession?.uid else { return }

        COLLECTION_FOLLOWING.document(currentUID).collection("user-following").document(uid).setData([:]) { error in
            guard  error == nil else { print(error!.localizedDescription); return }

            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUID).setData([:], completion: completion)
        }
    }

    static func unfollow(uid: String, completion: ((Error?) -> Void)?) {

        guard let currentUID = AuthViewModel.shared.userSession?.uid else { return }

        COLLECTION_FOLLOWING.document(currentUID).collection("user-following").document(uid).delete { error in
            guard  error == nil else { print(error!.localizedDescription); return }

            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUID).delete(completion: completion)
        }
    }

    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {

        guard let currentUID = AuthViewModel.shared.userSession?.uid else { return }

        COLLECTION_FOLLOWING.document(currentUID).collection("user-following").document(uid).getDocument { snapshot, error in
            guard error == nil else { print(error!.localizedDescription); return }

            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
}
