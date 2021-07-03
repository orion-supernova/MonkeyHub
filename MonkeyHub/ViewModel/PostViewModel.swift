//
//  UploadPostViewModel.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 26.05.2021.
//

import SwiftUI
import Firebase


class PostViewModel: ObservableObject {
    
    @Published var posts = [Post]()
    
    func uploadPost(caption: String, image: UIImage, completion: FirestoreCompletion) {
        guard let user = AuthViewModel.shared.currentUserObject else { return }
        
        ImageUploader.uploadImage(image: image, type: .post) { imageURL in
            
            let data = ["caption": caption,
                        "timestamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageURL": imageURL,
                        "ownerUID": user.id ?? "",
                        "ownerImageURL": user.profileImageURL,
                        "ownerUsername": user.username] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
            
        }
    }
    
    
    func removePost(documentID: String, imageURL: String, completion: FirestoreCompletion) {

       
        COLLECTION_POSTS.document(documentID).delete { error in
            guard error == nil else { print("remove post function error. \(error!.localizedDescription)"); return}
            
            Storage.storage().reference(forURL: imageURL).delete(completion: completion)
            
        }
        
        

        }
        
        
        
        
        
    }




