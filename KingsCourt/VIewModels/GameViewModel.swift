//
//  GameViewModel.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-08.
//

import Foundation
import SwiftData

class GameViewModel: ObservableObject {
    @Published var isAdding: Bool = true
    @Published var homeTeam: Team? = nil
    @Published var awayTeam: Team? = nil
    var modelContext: ModelContext? = nil
    
    func finishGame(){
        guard let homeTeam = homeTeam, let awayTeam = awayTeam else {
            return
        }
        let allPlayers = homeTeam.players + awayTeam.players
        guard let overallMVP = allPlayers.max(by: { $0.gamePoints < $1.gamePoints }) else {
            return
        }
        
        let homePlayers = homeTeam.players.map { player in
            GameHistoryPlayer(
                player: player,
                points: player.gamePoints,
                mvp: player.id == overallMVP.id
            )
        }
        
        let awayPlayers = awayTeam.players.map { player in
            GameHistoryPlayer(
                player: player,
                points: player.gamePoints,
                mvp: player.id == overallMVP.id
            )
        }
        let isHomeTeamWinner = homeTeam.points > awayTeam.points
        
        let gameHistory = GameHistory(
            awayTeam: GameHistoryTeam(players: awayPlayers, points: awayTeam.points, winner: !isHomeTeamWinner),
            homeTeam: GameHistoryTeam(players: homePlayers, points: homeTeam.points, winner: isHomeTeamWinner),
            date: Date.now
        )
        
        modelContext?.insert(gameHistory)
    }
    
}

