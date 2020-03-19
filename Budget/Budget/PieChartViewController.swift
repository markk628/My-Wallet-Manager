//
//  PieChartViewController.swift
//  Budget
//
//  Created by Mark Kim on 3/17/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {

    @IBOutlet weak var pieView: PieChartView!
    
    var expenses = [Expenses]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FireBaseFireStoreService.shared.read(from: .expenses, returning: Expenses.self) { (expenses) in
            self.expenses = expenses
            self.customizeChart(dataPoints: self.names, values: self.cost.map{ Double($0) })
        }
    }
    
    lazy var names = getExpenseNames()
    lazy var cost = getExpenseCosts()

    func getExpenseNames() -> [String] {
        var expensesNames: [String] = []
        for expense in expenses {
            print(expense.name)
            expensesNames.append(expense.name)
        }
        
        print(expensesNames)
        return expensesNames
    }

    func getExpenseCosts() -> [Double] {
        var expensesCosts: [Double] = []
        for expense in expenses {
            print(expense.cost)
            expensesCosts.append(Double(expense.cost))
        }

        print(expensesCosts)
        return expensesCosts
    }
    
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        // 4. Assign it to the chart’s data
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
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setUpPieChart(dataPoints: getExpenseNames(), values: getExpenseCosts())
//        }
//
//    func setUpPieChart(dataPoints: [String], values: [Double]) {
//
//        pieView.rotationAngle = 0
//
//        var dataEntries: [ChartDataEntry] = []
//        for i in 0..<dataPoints.count {
//            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
//            dataEntries.append(dataEntry)
//        }
//
//        let dataSet = PieChartDataSet(entries: dataEntries, label: nil)
//        let pieChartData = PieChartData(dataSet: dataSet)
//
//        let format = NumberFormatter()
//        format.numberStyle = .none
//        let formatter = DefaultValueFormatter(formatter: format)
//        pieChartData.setValueFormatter(formatter)
//
//
//        let color1 = NSUIColor(hex: 0x9BBFE0)
//        let color2 = NSUIColor(hex: 0xE8A09A)
//        let color3 = NSUIColor(hex: 0xFBE29F)
//        let color4 = NSUIColor(hex: 0xC6D68F)
//
//        dataSet.colors = [color1, color2, color3, color4]
//        dataSet.drawValuesEnabled = false
//
//        pieView.data = PieChartData(dataSet: dataSet)
//    }
//
//
//
//






