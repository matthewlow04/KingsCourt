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
            VStack {
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        vm.showingDatePicker.toggle()
                    } label: {
                        Image(systemName: "calendar")
                    }
                }
            }
            .sheet(isPresented: $vm.showingDatePicker) {
                VStack {
                    DatePicker("Select Date", selection: Binding(
                        get: { vm.selectedDate ?? Date() },
                        set: { vm.selectedDate = $0 }
                    ), displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                     
                    Button {
                        vm.selectedDate = nil
                        vm.showingDatePicker = false
                    } label: {
                        Text("Show All Dates")
                            .modifier(GoButtonModifier())
                            .padding()
                    }
                    
                    Button {
                        vm.showingDatePicker = false
                    } label: {
                        Text("Done")
                            .modifier(GoButtonModifier())
                            .padding()
                    }
                    .onDisappear{
                        vm.fetchGameLog()
                    }

                }
            }
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

            statHeaderView()
                .padding(.leading, 50)
            
            ForEach(team.players, id: \.player.id) { gamePlayer in
                playerStatsView(for: gamePlayer)
            }
            .font(.subheadline)
        }
    }

    @ViewBuilder
    func statHeaderView() -> some View {
        HStack(spacing: 4) {
            Spacer()
            statHeaderText("PTS")
            statHeaderText("AST")
            statHeaderText("RBD")
            statHeaderText("STL")
            statHeaderText("BLK")
        }
    }

    @ViewBuilder
    func statHeaderText(_ title: String) -> some View {
        Text(title)
            .font(.footnote)
            .opacity(0.3)
            .frame(width: 30)
    }

    @ViewBuilder
    func playerStatsView(for gamePlayer: GameHistoryPlayer) -> some View {
        HStack {

            if vm.checkDeletedPlayer(player: gamePlayer) {
                Text("Deleted Player")
                    .foregroundStyle(.foreground)
            } else {
                NavigationLink(destination: PlayerView(player: gamePlayer.player)) {
                    Text("\(gamePlayer.player.firstName.prefix(1)). \(gamePlayer.player.lastName)")
                        .lineLimit(1)
                }
                .foregroundStyle(.foreground)
            }

            if gamePlayer.mvp {
                Image(systemName: "crown.fill")
                    .foregroundStyle(.yellow)
            }
            Spacer()

            HStack(spacing: 4) {
                statValueText(gamePlayer.points)
                statValueText(gamePlayer.assists)
                statValueText(gamePlayer.rebounds)
                statValueText(gamePlayer.steals)
                statValueText(gamePlayer.blocks)
            }
        }
    }

    @ViewBuilder
    func statValueText(_ value: Int) -> some View {
        Text(String(value))
            .frame(width: 30)
    }


}

