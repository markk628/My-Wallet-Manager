//
//  CRUDExpense.swift
//  Budget
//
//  Created by Mark Kim on 3/17/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation
import UIKit

class CRUDExpense {
    
    private init() {}
    
    static func createExpense(in vc: UIViewController, completion: @escaping (Expenses) -> Void) {
        
        let alert = UIAlertController(title: "Add Expense", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (nameTF) in
            nameTF.placeholder = "Name"
        }
        
        alert.addTextField { (costTF) in
            costTF.placeholder = "Cost"
            costTF.keyboardType = .numberPad
        }
        
        let add = UIAlertAction(title: "Add", style: .default) { _ in
            guard
                let name = alert.textFields?.first?.text,
                let costString = alert.textFields?.last?.text,
                let cost = Int(costString)
            else { return }
            
            print(name)
            print(cost)
            
            let expense = Expenses(name: name, cost: cost)
            completion(expense)
        }
        alert.addAction(add)
        vc.present(alert, animated: true)
    }
    
    static func updateExpense(_ expense: Expenses, in vc: UIViewController, completion: @escaping (Expenses) -> Void) {
        
        let alert = UIAlertController(title: "Update \(expense.name)", message: nil, preferredStyle: .alert)
        
        alert.addTextField{ (costTF) in
            costTF.placeholder = "Cost"
            costTF.keyboardType = .numberPad
            costTF.text = String(expense.cost)
    }
        
        let update = UIAlertAction(title: "Update", style: .default) { _ in
            guard
                let costString = alert.textFields?.last?.text,
                let cost = Int(costString)
            else { return }
            
            var updatedExpense = expense
            updatedExpense.cost = cost
            
            completion(updatedExpense)
        }
        
        alert.addAction(update)
        vc.present(alert, animated: true)
    }
}
