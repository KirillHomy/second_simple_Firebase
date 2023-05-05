//
//  APIManager.swift
//  second_simple_Firebase
//
//  Created by Kirill Khomytsevych on 04.05.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class APIManager {

    static let shared = APIManager()

    // MARK: - Internal Method
    func getPost(collection: String, docName: String, completion: @escaping (FirebaseModel?) -> Void) {
        let db = configureFB()
        db.collection(collection).document(docName).getDocument { document, error in
            guard error == nil else {
                completion(nil)
                return
            }
            let doc = FirebaseModel(type: document?.get("type") as! String, model: document?.get("model") as! String)
            completion(doc)
        }
    }

    func getImage(picName: String, competion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("pictures")

        let imageDefault = UIImage(systemName: "star")
        guard let imageDefault = imageDefault else { return }

        let fileRef = pathRef.child(picName + ".jpeg")
        fileRef.getData(maxSize: 2024 * 2024) { data, error in
            guard error == nil,
                  let data = data else {
                competion(imageDefault)
                return
            }
            let imageData = UIImage(data: data)
            guard let imageData = imageData else { return }

            competion(imageData)
            
        }
    }

}

// MARK: - Private extension
private extension APIManager {

    func configureFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }

}
