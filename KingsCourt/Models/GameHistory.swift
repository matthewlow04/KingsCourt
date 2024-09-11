//
//  GameHistory.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-07.
//

import Foundation
import SwiftData


@Model
class GameHistory: Identifiable{
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

@Model
class GameHistoryTeam{
    var players: [GameHistoryPlayer]
    var points: Int
    var winner: Bool
    
    init(players: [GameHistoryPlayer], points: Int, winner: Bool) {
        self.players = players
        self.points = points
        self.winner = winner
    }
}

@Model
class GameHistoryPlayer{
    var player: Player
    var points: Int
    var mvp: Bool
    
    init(player: Player, points: Int, mvp: Bool) {
        self.player = player
        self.points = points
        self.mvp = mvp
    }
}


