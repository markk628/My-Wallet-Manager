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
    
    let addExpenseBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = .add
        barButton.action = #selector(ExpenseViewController.addTapped)
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FireBaseFireStoreService.shared.read(from: .expenses, returning: Expenses.self) { (expenses) in
            self.expenses = expenses
            self.tableView.reloadData()
        }
    }
    
    @objc func addTapped() {
        CRUDExpense.createExpense(in: self) { expense in
            FireBaseFireStoreService.shared.create(for: expense, in: .expenses)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let expense = expenses[indexPath.row]
        
        cell.textLabel?.text = expense.name
        cell.detailTextLabel?.text = "$\(expense.cost)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let expense = expenses[indexPath.row]
        
        CRUDExpense.updateExpense(expense, in: self) { updatedExpense in
            FireBaseFireStoreService.shared.update(for: updatedExpense, in: .expenses)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let expense = expenses[indexPath.row]
        FireBaseFireStoreService.shared.delete(expense, in: .expenses)
    }
    
}
