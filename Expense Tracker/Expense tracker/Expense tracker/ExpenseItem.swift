//
//  ExpenseItem.swift
//  Expense tracker
//
//  Created by Bukhari Sani on 22/03/2023.
//

import Foundation
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
