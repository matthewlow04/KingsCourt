//
//  KingsCourtApp.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI
import SwiftData


@main
struct KingsCourtApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Player.self, GameHistory.self])
    }
}
