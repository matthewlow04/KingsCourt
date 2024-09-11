//
//  GameLogView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI
import SwiftData

import SwiftUI
import SwiftData

struct GameLogView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject var vm = GameLogViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                if vm.gameHistories.isEmpty {
                    Text("No Past Games")
                        .italic()
                } else {
                    ScrollView {
                        ForEach(vm.gameHistories) { gameHistory in
                            gameHistoryView(gameHistory)
                        }
                    }
                }
            }
            .navigationTitle("Game History")
            .onAppear {
                vm.modelContext = modelContext
                vm.fetchGameLog()
            }
        }
    }
    
    @ViewBuilder
    func gameHistoryView(_ gameHistory: GameHistory) -> some View {
        VStack(alignment: .leading) {
            Text(gameHistory.date.formatted(date: .abbreviated, time: .omitted))
            Text("ID: \(gameHistory.id.uuidString)")
                .font(.footnote)
                .opacity(0.3)
                .padding(.bottom)
            
            gameTeamView(team: gameHistory.awayTeam, isAway: true)
            
            Divider()
                .padding()
            
            gameTeamView(team: gameHistory.homeTeam, isAway: false)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 25.0)
        .stroke(style: StrokeStyle(lineWidth: 0.5, dashPhase: 2.0)))
        .padding()
    }
    
    @ViewBuilder
    func gameTeamView(team: GameHistoryTeam, isAway: Bool) -> some View {
        VStack {
            HStack {
                Text(isAway ? "Away" : "Home")
                    .font(.headline)
                if team.winner {
                    Image(systemName: "medal.fill")
                        .foregroundStyle(.green)
                }
                Spacer()
                Text(String(team.points))
                    .font(.largeTitle)
            }
            
            ForEach(team.players, id: \.player.id) { gamePlayer in
                HStack {
                    if vm.checkDeletedPlayer(player: gamePlayer){
                        Text("Deleted Player")
                            .foregroundStyle(.foreground)
                    } else {
                        NavigationLink(destination: PlayerView(player: gamePlayer.player)) {
                            Text("\(gamePlayer.player.firstName.prefix(1)). \(gamePlayer.player.lastName)")
                        }
                        .foregroundStyle(.foreground)
                    }
                    
                  
                    if gamePlayer.mvp {
                        Image(systemName: "crown.fill")
                            .foregroundStyle(.yellow)
                    }
                    Spacer()
                    Text(String(gamePlayer.points))
                }
            }
            .font(.subheadline)
        }
    }
}
