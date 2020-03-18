//
//  ExpensesViewController.swift
//  Budget
//
//  Created by Mark Kim on 3/17/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation
import UIKit

class ExpenseViewController: UITableViewController {
    
    var expenses = [Expenses]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTapped() {
        CRUDExpense.createExpense(in: self) { expense in
            print(expense)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let expense = expenses[indexPath.row]
        
        cell.textLabel?.text = expense.name
        cell.detailTextLabel?.text = String(expense.cost)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let expense = expenses[indexPath.row]
        
        CRUDExpense.updateExpense(expense, in: self) { updatedExpense in
            print(updatedExpense)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
    }
    
}
