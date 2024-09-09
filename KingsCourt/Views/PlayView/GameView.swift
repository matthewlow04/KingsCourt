//
//  GameView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-08.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var vm = GameViewModel()
    @ObservedObject var homeTeam: Team
    @ObservedObject var awayTeam: Team
    
    var body: some View {
        VStack {
            Divider()
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(homeTeam.players, id: \.id) { player in
                        PlayerScoreView(player: player, team: homeTeam, vm: vm)
                    }
                }
                .font(.subheadline)
            }
            .scrollIndicators(.hidden)
            
            VStack {
                HStack {
                    Text("Home")
                    Spacer()
                    Text(String(homeTeam.points))
                        .font(.system(size: 50))
                }
                HStack {
                    Text("Away")
                    Spacer()
                    Text(String(awayTeam.points))
                        .font(.system(size: 50))
                }
            }
            .font(.headline)
            
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(awayTeam.players, id: \.id) { player in
                        PlayerScoreView(player: player, team: awayTeam, vm: vm)
                    }
                }
                .font(.subheadline)
            }
            .scrollIndicators(.hidden)
            
            Button(action: {
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
                
                dump(gameHistory)
            }, label: {
                Text("Finish")
                    .modifier(GoButtonModifier())
            })

        }
        .padding()
        .navigationTitle("King's Court")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    vm.isAdding.toggle()
                }) {
                    Image(systemName: vm.isAdding ? "plus" : "minus")
                }
            }
        }
    }
}



struct PlayerScoreView: View {
    @ObservedObject var player: Player
    @ObservedObject var team: Team
    @ObservedObject var vm: GameViewModel
    
    var body: some View {
        HStack(spacing: 25) {
            Text(player.firstName.prefix(1) + "." + player.lastName)
            
            Spacer()
            
            Button {
                if vm.isAdding {
                    player.gamePoints += 1
                    team.points += 1
                    
                } else {
                    if player.gamePoints > 0 {
                        player.gamePoints -= 1
                        team.points -= 1
                        
                    }
                }
            } label: {
                VStack {
                    Text("Pts")
                    Text(String(player.gamePoints))
                }
            }
            
            Button {
                if vm.isAdding {
                    player.gameAssists += 1
                } else {
                    if player.gameAssists > 0 {
                        player.gameAssists -= 1
                    }
                }
            } label: {
                VStack {
                    Text("Ast")
                    Text(String(player.gameAssists))
                }
            }
            
            Button {
                if vm.isAdding {
                    player.gameRebounds += 1
                } else {
                    if player.gameRebounds > 0 {
                        player.gameRebounds -= 1
                    }
                }
            } label: {
                VStack {
                    Text("Rbd")
                    Text(String(player.gameRebounds))
                }
            }
            
            Button {
                if vm.isAdding {
                    player.gameSteals += 1
                } else {
                    if player.gameSteals > 0 {
                        player.gameSteals -= 1
                    }
                }
            } label: {
                VStack {
                    Text("Stl")
                    Text(String(player.gameSteals))
                }
            }
            
            Button {
                if vm.isAdding {
                    player.gameBlocks += 1
                } else {
                    if player.gameBlocks > 0 {
                        player.gameBlocks -= 1
                    }
                }
            } label: {
                VStack {
                    Text("Blk")
                    Text(String(player.gameBlocks))
                }
            }
        }
    }
}
