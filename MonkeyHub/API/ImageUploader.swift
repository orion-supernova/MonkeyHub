//
//  ImageUploader.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 25.05.2021.
//

import UIKit
import Firebase


enum UploadType {
    
    case profile
    case post
    
    var filePath: StorageReference {
        
        let fileName = NSUUID().uuidString

        switch self {
        case .profile:
            return Storage.storage().reference(withPath: "/images/profile_pictures/\(fileName).jpg")
        case .post:
            return Storage.storage().reference(withPath: "/images/post_images/\(fileName).jpg")
        }
    }
}

struct ImageUploader {
    
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping(String) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let ref = type.filePath
        
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if error != nil {
                print("Failed to upload image. \(error!.localizedDescription)")
                return
            }
            
            print("Succesfully uploaded the image via ImageUploader!")
            
            ref.downloadURL { url, error in
                guard let imageURL = url?.absoluteString else { return }
                completion(imageURL)
            }
        }
        
    }
}
