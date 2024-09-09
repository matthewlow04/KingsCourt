//
//  GameViewModel.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-08.
//

import Foundation

class GameViewModel: ObservableObject{
    @Published var homeTeam = Team(players: [], type: .home)
    @Published var awayTeam = Team(players: [], type: .away)
    @Published var isAdding = true
}
