//
//  Alert.swift
//  AI Tic Tac Toe
//
//  Created by Bukhari Sani on 02/01/2023.
//

import SwiftUI

struct AlertItem: Identifiable{
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
    
}

struct AlertContext {
   static let humanWIn = AlertItem(title:Text ("You Win!"),
                        message: Text("The matrix is defeated. You saved Zion."),
                        buttonTitle: Text("Oh Yeah!"))
    
    static let AIWIn = AlertItem(title:Text("The Matrix Defeated You"),
                        message: Text ("Back to the simulation."),
                        buttonTitle: Text("Morpheus Help!"))
    
    static let draw = AlertItem(title:Text("It's a draw"),
                        message: Text ("You need to meet the architect."),
                        buttonTitle: Text("Let's Meet The Oracle"))
}
