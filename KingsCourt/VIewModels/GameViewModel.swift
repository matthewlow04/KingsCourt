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
    @Published var showingAlert = false
    var alertTitle = ""
    var alertMessage = ""
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
        
        for player in allPlayers{
            player.points += Double(player.gamePoints)
            player.assists += Double(player.gameAssists)
            player.rebounds += Double(player.gameRebounds)
            player.blocks += Double(player.gameBlocks)
            player.steals += Double(player.gameSteals)
            player.games += 1
            
            if player.id == overallMVP.id{
                player.mvps += 1
            }
        }
        
        for player in homeTeam.players{
            if isHomeTeamWinner{
                player.wins += 1
            } else {
                player.losses += 1
            }
        }
        
        for player in awayTeam.players{
            if isHomeTeamWinner{
                player.losses += 1
            } else {
                player.wins += 1
            }
        }
        
        modelContext?.insert(gameHistory)
        clearStats()
    }
    
    func clearStats(){
        guard let homeTeam = homeTeam, let awayTeam = awayTeam else {
            return
        }
        for player in awayTeam.players{
            player.gamePoints = 0
            player.gameAssists = 0
            player.gameBlocks = 0
            player.gameRebounds = 0
            player.gameSteals = 0
        }
        for player in homeTeam.players{
            player.gamePoints = 0
            player.gameAssists = 0
            player.gameBlocks = 0
            player.gameRebounds = 0
            player.gameSteals = 0
        }
        
        awayTeam.points = 0
        homeTeam.points = 0
    }
    
}

