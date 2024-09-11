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
    @Published var selectedDate: Date? = nil
    @Published var showingDatePicker = false
    var modelContext: ModelContext? = nil
    
    func fetchGameLog() {
        let fetchDescriptor = FetchDescriptor<GameHistory> (
            sortBy: [SortDescriptor(\.date ,order: .reverse)]
        )
        
        var fetchedGames = (try? (modelContext?.fetch(fetchDescriptor) ?? [])) ?? []
        
        if let selectedDate = selectedDate {
            let calendar = Calendar.current
            fetchedGames = fetchedGames.filter { gameHistory in
                calendar.isDate(gameHistory.date, inSameDayAs: selectedDate)
            }
        }
        
        gameHistories = fetchedGames
    }
    
    func checkDeletedPlayer(player: GameHistoryPlayer) -> Bool {
        return (player.player.firstName == "Deleted" && player.player.lastName == "Player")
    }
}
