//
//  GameHistory.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-07.
//

import Foundation

class GameHistory{
    var awayTeam: GameHistoryTeam
    var homeTeam: GameHistoryTeam
    var date: Date
    var id = UUID()
    
    init(awayTeam: GameHistoryTeam, homeTeam: GameHistoryTeam, date: Date, id: UUID = UUID()) {
        self.awayTeam = awayTeam
        self.homeTeam = homeTeam
        self.date = date
        self.id = id
    }

}

struct GameHistoryPlayer{
    var player: Player
    var points: Int
    var mvp: Bool
}

struct GameHistoryTeam{
    var players: [GameHistoryPlayer]
    var points: Int
    var winner: Bool
}
