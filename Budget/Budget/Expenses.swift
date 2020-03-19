//
//  Expenses.swift
//  Budget
//
//  Created by Mark Kim on 3/17/20.
//  Copyright © 2020 Mark Kim. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: String? { get set }
}

struct Expenses: Codable, Identifiable {
    
    var id: String? = nil
    let name: String
    var cost: Int
    
    init(name: String, cost: Int) {
        self.name = name
        self.cost = cost
    }
}
