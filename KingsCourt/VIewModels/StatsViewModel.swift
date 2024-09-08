//
//  StatsViewModel.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-08.
//

import Foundation

class StatsViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedPositions: [Player.Position] = []
    @Published var sortOption = 0
    @Published var sortDescending = true

    var filteredPlayers: [Player] {
        Player.mockPlayers.filter { player in
            (searchText.isEmpty || player.name.localizedCaseInsensitiveContains(searchText)) &&
            (selectedPositions.isEmpty || selectedPositions.allSatisfy { player.position.contains($0) })
        }
    }
    var sortedPlayers: [Player] {
        let players = filteredPlayers
        switch sortOption {
        case 0:
            return players.sorted { sortDescending ? ($0.name > $1.name) : ($0.name < $1.name)  }
        default:
            return players
        }

    }
}
