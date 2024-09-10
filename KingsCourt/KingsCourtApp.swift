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
//
//struct KingsCourtApp: App {
//    
//    let container: ModelContainer
//        init() {
//            do {
//                let config = ModelConfiguration(for: Player.self, GameHistory.self)
//                container = try ModelContainer(for: Player.self, GameHistory.self, configurations: config)
//            } catch {
//                fatalError("Could not initialize ModelContainer")
//            }
//        }
//    
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//               
//        }
//        .modelContainer(for: [Player.self, GameHistory.self])
//    }
//}
