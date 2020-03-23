//
//  BarChartViewController.swift
//  Budget
//
//  Created by Mark Kim on 3/20/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit
import Charts
import Firebase
import FirebaseFirestoreSwift

class BarChartViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var barView: BarChartView!
        
    var expenses = [Expenses]()

    lazy var names = getExpenseNames()
    lazy var cost = getExpenseCosts()

    func getExpenseNames() -> [String] {
        var expensesNames: [String] = []
        
        for expense in expenses {
            expensesNames.append(expense.name)
        }
//        expensesNames.append("Free")
        return expensesNames
    }

    func getExpenseCosts() -> [Double] {
        var expensesCosts: [Double] = []
//        let freeAmount = CalculateBudget()
//        freeAmount.calculateBudget()
        
        for expense in expenses {
            expensesCosts.append(Double(expense.cost))
        }
//        expensesCosts.append(freeAmount.calculateBudget())
        return expensesCosts
    }
    
    func customizeChart(names: [String], costs: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<names.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(costs[i]), data: names[i] as String)
            dataEntries.append(dataEntry)
        }
                
        let barChartDataSet = BarChartDataSet(entries: dataEntries, label: nil)
        barChartDataSet.colors = colorsOfCharts(numbersOfColor: names.count)
        
        let barChartData = BarChartData(dataSet: barChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        barChartData.setValueFormatter(formatter)
        
        barView.data = barChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let freeAmount = CalculateBudget()
//        freeAmount.calculateBudget()
        
        FireBaseFireStoreService.shared.read(from: .expenses, returning: Expenses.self) { (expenses) in
            self.expenses = expenses
            self.customizeChart(names: self.names, costs: self.cost.map{ Double($0) })
        }
    }
}
