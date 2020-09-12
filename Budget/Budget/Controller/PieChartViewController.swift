//
//  PieChartViewController.swift
//  Budget
//
//  Created by Mark Kim on 3/17/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit
import Charts
import Firebase
import FirebaseFirestoreSwift

class PieChartViewController: UIViewController, UITabBarControllerDelegate {
    
    var expenses = [Expenses]()
    
    lazy var names = getExpenseNames()
    lazy var cost = getExpenseCosts()
    
    let pieView: PieChartView = {
        let pie = PieChartView()
        pie.translatesAutoresizingMaskIntoConstraints = false
        return pie
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPieChartVC()
        view.backgroundColor = .white
        
        FireBaseFireStoreService.shared.read(from: .expenses, returning: Expenses.self) { (expenses) in
            self.expenses = expenses
            self.customizeChart(names: self.names, costs: self.cost.map{ Double($0) })
        }
    }
    
    func setUpPieChartVC() {
        view.addSubview(pieView)
        
        NSLayoutConstraint.activate([
            pieView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pieView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pieView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pieView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func getExpenseNames() -> [String] {
        var expensesNames: [String] = []
        
        for expense in expenses {
            expensesNames.append(expense.name)
        }
        return expensesNames
    }

    func getExpenseCosts() -> [Double] {
        var expensesCosts: [Double] = []

        for expense in expenses {
            expensesCosts.append(Double(expense.cost))
        }
        return expensesCosts
    }
    
    func customizeChart(names: [String], costs: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<names.count {
            let dataEntry = PieChartDataEntry(value: costs[i], label: names[i], data: names[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: names.count)
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .currency
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        pieView.data = pieChartData
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
}







