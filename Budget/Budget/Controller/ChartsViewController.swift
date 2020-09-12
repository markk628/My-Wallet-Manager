//
//  ChartsViewController.swift
//  Budget
//
//  Created by Mark Kim on 7/30/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit

class ChartsViewController: UIViewController {
    
    let pieChartVCButton: UIButton = {
        let pieBtn = UIButton()
        pieBtn.setTitle("Pie Chart", for: UIControl.State.normal)
        pieBtn.backgroundColor = .red
        pieBtn.layer.cornerRadius = 10
        pieBtn.translatesAutoresizingMaskIntoConstraints = false
        return pieBtn
    }()
    
    let barChartVCButton: UIButton = {
        let barBtn = UIButton()
        barBtn.setTitle("Bar Chart", for: UIControl.State.normal)
        barBtn.backgroundColor = .blue
        barBtn.layer.cornerRadius = 10
        barBtn.translatesAutoresizingMaskIntoConstraints = false
        return barBtn
    }()
    
    @objc func pieChartVCButtonTapped() {
        let pieChartVC = PieChartViewController()
        self.navigationController?.pushViewController(pieChartVC, animated: true)
    }
    
    @objc func barChartVCButtonTapped() {
        let barChartVC = BarChartViewController()
        self.navigationController?.pushViewController(barChartVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButtons()
        pieChartVCButton.addTarget(self, action: #selector(pieChartVCButtonTapped), for: .touchUpInside)
        barChartVCButton.addTarget(self, action: #selector(barChartVCButtonTapped), for: .touchUpInside)
    }
    
    func setUpButtons() {
        view.addSubview(pieChartVCButton)
        view.addSubview(barChartVCButton)
        
        NSLayoutConstraint.activate([
            pieChartVCButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pieChartVCButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            pieChartVCButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
            pieChartVCButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22),
            
            barChartVCButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            barChartVCButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            barChartVCButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
            barChartVCButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22)
        ])
    }

}
