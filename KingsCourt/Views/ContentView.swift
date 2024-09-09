//
//  ContentView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            PlayView()
                .tabItem{Label("Play", systemImage: "basketball.fill")}
            AddPlayerView()
                .tabItem{Label("Add Player", systemImage: "person.fill.badge.plus")}
            StatsView()
                .tabItem{Label("Stats", systemImage: "chart.bar.fill")}
            GameLogView(gameHistory:GameHistory(
                awayTeam: GameHistoryTeam(players: [
                    GameHistoryPlayer(player: Player.mockPlayers[0], points: 10, mvp: false),
                    GameHistoryPlayer(player: Player.mockPlayers[1], points: 6, mvp: false),
                    GameHistoryPlayer(player: Player.mockPlayers[2], points: 5, mvp: false)
                ], points: 21, winner: true),
                homeTeam: GameHistoryTeam(players: [
                    GameHistoryPlayer(player: Player.mockPlayers[3], points: 7, mvp: true),
                    GameHistoryPlayer(player: Player.mockPlayers[4], points: 3, mvp: false),
                    GameHistoryPlayer(player: Player.mockPlayers[5], points: 3, mvp: false)
                ], points: 13, winner: false),
                date: Date()
            ))
                .tabItem{Label("Game Log", systemImage: "scroll.fill")}
        }
    }
}

#Preview {
    ContentView()
}
