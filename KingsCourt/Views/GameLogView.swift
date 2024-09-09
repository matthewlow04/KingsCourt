//
//  GameLogView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI

struct GameLogView: View {
    var gameHistory: GameHistory
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(gameHistory.date.formatted(date: .abbreviated, time: .omitted))
                        Text("ID: \(gameHistory.id.uuidString)")
                            .font(.footnote)
                            .opacity(0.3)
                            .padding(.bottom)
                        
                        VStack {
                            HStack {
                                Text("Away")
                                    .font(.headline)
                                if gameHistory.awayTeam.winner {
                                    Image(systemName: "medal.fill")
                                        .foregroundStyle(.green)
                                }
                                Spacer()
                                Text(String(gameHistory.awayTeam.points))
                                    .font(.largeTitle)
                            }
                            Group {
                                ForEach(gameHistory.awayTeam.players, id: \.player.id) { gamePlayer in
                                    HStack {
                                        Text(gamePlayer.player.firstName)
                                        if gamePlayer.mvp {
                                            Image(systemName: "crown.fill")
                                                .foregroundStyle(.yellow)
                                        }
                                        Spacer()
                                        Text(String(gamePlayer.points))
                                    }
                                }
                            }
                            .font(.subheadline)
                        }
                        Divider()
                            .padding()
                        VStack {
                            HStack {
                                Text("Home")
                                    .font(.headline)
                                Spacer()
                                if gameHistory.homeTeam.winner {
                                    Image(systemName: "medal.fill")
                                        .foregroundStyle(.green)
                                }
                                Text(String(gameHistory.homeTeam.points))
                                    .font(.largeTitle)
                            }
                            Group {
                                ForEach(gameHistory.homeTeam.players, id: \.player.id) { gamePlayer in
                                    HStack {
                                        Text(gamePlayer.player.firstName)
                                        if gamePlayer.mvp {
                                            Image(systemName: "crown.fill")
                                                .foregroundStyle(.yellow)
                                        }
                                        Spacer()
                                        Text(String(gamePlayer.points))
                                    }
                                }
                            }
                            .font(.subheadline)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 25.0).stroke(style: StrokeStyle(lineWidth: 0.5, dashPhase: 2.0)))
                    .padding()
                }
            }
            .navigationTitle("Game History")
        }
    }
}

#Preview {
    GameLogView(gameHistory: GameHistory(
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
}
