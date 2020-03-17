//
//  Expenses.swift
//  Budget
//
//  Created by Mark Kim on 3/17/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ExpensesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        db.collection("851 rent").addDocument(data: ["cost": 975, "type":"rent"])
    }
}
