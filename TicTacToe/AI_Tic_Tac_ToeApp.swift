//
//  AI_Tic_Tac_ToeApp.swift
//  AI Tic Tac Toe
//
//  Created by Bukhari Sani on 31/12/2022.
//

import SwiftUI

@main
struct AI_Tic_Tac_ToeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GameView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
