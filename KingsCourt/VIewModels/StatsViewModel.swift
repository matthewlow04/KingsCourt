//
//  StatsViewModel.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-08.
//

import Foundation
import SwiftData

class StatsViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedPositions: [Player.Position] = []
    @Published var sortOption = 0
    @Published var sortDescending = true
    @Published var players: [Player] = []
    var modelContext: ModelContext? = nil

    var filteredPlayers: [Player] {
        players.filter { player in
            (searchText.isEmpty || player.firstName.localizedCaseInsensitiveContains(searchText) || player.lastName.localizedCaseInsensitiveContains(searchText)
            ) &&
            (selectedPositions.isEmpty || selectedPositions.allSatisfy { player.position.contains($0) })
        }
    }
    var sortedPlayers: [Player] {
        let players = filteredPlayers
        switch sortOption {
        case 0:
            return players.sorted { sortDescending ? ($0.firstName > $1.firstName) : ($0.firstName < $1.firstName)  }
        case 1:
            return players.sorted { sortDescending ? ($0.lastName > $1.lastName) : ($0.lastName < $1.lastName)  }
        default:
            return players
        }

    }
    
    func fetchPlayers(){
        let fetchDescriptor = FetchDescriptor<Player> (
            sortBy: [SortDescriptor(\.firstName)]
        )
        
        players = (try? (modelContext?.fetch(fetchDescriptor) ?? [])) ?? []
    }
}
