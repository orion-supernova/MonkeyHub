//
//  Constants.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 26.05.2021.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")
let COLLECTION_DIRECTMESSAGES = Firestore.firestore().collection("dmConversations")

