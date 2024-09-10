//
//  GameLogViewModel.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-09.
//

import Foundation
import SwiftData

class GameLogViewModel: ObservableObject {
    @Published var gameHistories: [GameHistory] = []
    var modelContext: ModelContext? = nil
    
    
    func fetchGameLog(){
        let fetchDescriptor = FetchDescriptor<GameHistory> (
            sortBy: [SortDescriptor(\.date ,order: .reverse)]
        )
        
        gameHistories = (try? (modelContext?.fetch(fetchDescriptor) ?? [])) ?? []
    }
}
