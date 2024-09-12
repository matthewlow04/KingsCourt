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
        case 2:
            return players.sorted { sortDescending ? ($0.ppg > $1.ppg) : ($0.ppg < $1.ppg)  }
        case 3:
            return players.sorted { sortDescending ? ($0.apg > $1.apg) : ($0.apg < $1.apg)  }
        case 4:
            return players.sorted { sortDescending ? ($0.rpg > $1.rpg) : ($0.rpg < $1.rpg)  }
        case 5:
            return players.sorted { sortDescending ? ($0.date ?? Date.distantPast > $1.date ?? Date.distantPast) : ($0.date ?? Date.distantPast < $1.date ?? Date.distantPast)  }
        default:
            return players
        }

    }
    
    func formattedStat(_ stat: Double) -> String {
        String(format: "%.2f", stat)
    }
    
    func fetchPlayers(){
        let fetchDescriptor = FetchDescriptor<Player> (
            sortBy: [SortDescriptor(\.firstName)]
        )
        
        players = (try? (modelContext?.fetch(fetchDescriptor) ?? [])) ?? []
        players = players.filter { !($0.firstName == "Deleted" && $0.lastName == "Player") }
    }
}
