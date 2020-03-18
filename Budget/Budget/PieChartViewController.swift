//
//  PieChartViewController.swift
//  Budget
//
//  Created by Mark Kim on 3/17/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit
import Charts
import FirebaseFirestore

class PieChartViewController: UIViewController{
    
    @IBOutlet weak var pieView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPieChart()
    }
    
    func setUpPieChart() {
                        
        pieView.rotationAngle = 0
        
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: 975.0, label: "851 Rent"))
        entries.append(PieChartDataEntry(value: 40.0, label: "Protein"))
        entries.append(PieChartDataEntry(value: 35.0, label: "Gym"))
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        let color1 = NSUIColor(hex: 0x9BBFE0)
        let color2 = NSUIColor(hex: 0xE8A09A)
        let color3 = NSUIColor(hex: 0xFBE29F)
        let color4 = NSUIColor(hex: 0xC6D68F)
        
        dataSet.colors = [color1, color2, color3, color4]
        dataSet.drawValuesEnabled = false
        
        pieView.data = PieChartData(dataSet: dataSet)
    }
}
