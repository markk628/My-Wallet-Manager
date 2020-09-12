//
//  CAndETabBarController.swift
//  Budget
//
//  Created by Mark Kim on 6/14/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import UIKit

class CAndETabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Wallet Manager"
        view.backgroundColor = .white
        setUpViewControllers()
        self.delegate = self
    }
    
    private func setUpViewControllers() {
        var viewControllerArray = [UIViewController]()
        let viewControllerClasses = [ChartsViewController(), ExpenseViewController()]
        let titles = ["Charts", "Expenses"]
        let tabBarIcons = [
            UITabBarItem(tabBarSystemItem: .featured, tag: 0),
            UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1),
        ]
        
        for i in 0..<viewControllerClasses.count {
            let vc = viewControllerClasses[i]
            vc.title = titles[i]
            vc.tabBarItem = tabBarIcons[i]
            
            self.tabBar.barTintColor = .white
            self.tabBar.tintColor = UIColor(red: 0/255, green: 62/255, blue: 70/255, alpha: 1.0)
            
            viewControllerArray.append(vc)
        }
        viewControllers = viewControllerArray
    }
    
    private func setUpNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addTapped() {
        CRUDExpense.createExpense(in: self) { expense in
            FireBaseFireStoreService.shared.create(for: expense, in: .expenses)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if(viewController.isKind(of: ExpenseViewController.self)){
            setUpNavBar()
        }else{
            navigationItem.rightBarButtonItem = nil
            navigationItem.leftBarButtonItem = nil
        }
    }
}
