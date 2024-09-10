//
//  GameLogView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI
import SwiftData

struct GameLogView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject var vm = GameLogViewModel()
    
    var body: some View {
        NavigationStack {
               VStack{
                   if (vm.gameHistories.isEmpty){
                       Text("No Past Games")
                           .italic()
                   } else {
                    ScrollView {
                        ForEach(vm.gameHistories){ gameHistory in
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
                }
            }
            .navigationTitle("Game History")
            .onAppear{
                vm.modelContext = modelContext
                vm.fetchGameLog()
            }
        }
    }
}


