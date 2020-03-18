//
//  FireBaseFireStoreService.swift
//  Budget
//
//  Created by Mark Kim on 3/18/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class FireBaseFireStoreService {
    
    private init() {}
    static let shared = FireBaseFireStoreService()
        
    func configure() {
        FirebaseApp.configure()
    }
    
//    let expenseReference = Firestore.firestore().collection("expenses")
    
    func create() {
        
        let expenseReference = Firestore.firestore().collection("expenses")

        let parameters =
        
        expenseReference.addDocument(data: <#T##[String : Any]#>)
    }
    
    func read() {
        
        let expenseReference = Firestore.firestore().collection("expenses")
        
        expenseReference.addSnapshotListener { (snapshot, _) in
            
            guard let snapshot = snapshot else { return }
            
            for document in snapshot.documents {
                print(document.data())
            }
        }
        
    }
    
    func update() {
        
        let expenseReference = Firestore.firestore().collection("expenses")
        
        expenseReference.document("doc id").setData(<#T##documentData: [String : Any]##[String : Any]#>)

        
    }
    
    func delete() {
        
        let expenseReference = Firestore.firestore().collection("expenses")
        
        expenseReference.document("doc id").delete()
        
    }
}
