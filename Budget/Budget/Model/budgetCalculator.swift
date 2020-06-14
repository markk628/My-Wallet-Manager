//
//  budgetCalculator.swift
//  Budget
//
//  Created by Mark Kim on 3/20/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

//import Foundation
//import UIKit
//import Firebase
//import FirebaseFirestoreSwift
//
//class CalculateBudget {
//    
//    var expensesCollectionRef: CollectionReference!
//    var incomeCollectionRef: CollectionReference!
//    
//    func calculateBudget() {
//        expensesCollectionRef = Firestore.firestore().collection("expenses")
//        incomeCollectionRef = Firestore.firestore().collection("income")
//        var totalAmount: Int = 600
////        print(incomeCollectionRef)
//        
//        expensesCollectionRef.getDocuments { (snapshot, error) in
//            if let err = error {
//                debugPrint("Error fetching docs: \(err)")
//            } else {
//                guard let snap = snapshot else { return }
//                for document in snap.documents {
//                    let data = document.data()
//                    let cost = data["cost"] as? Int ?? 0
//                    print(cost)
//                    totalAmount -= cost
//                }
//            }
//            if totalAmount > 0 {
//                self.incomeCollectionRef.addDocument(data: [
//                    "incomeType": "Free",
//                    "incomeAmount": Double(totalAmount)
//                ])
//            } else {
//                return
//            }
//        }
//    }
//}

