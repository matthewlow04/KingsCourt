//
//  PlayView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI
import SwiftData

struct PlayView: View {
    
    @StateObject var vm = PlayViewModel()
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Group{
                        Text("Players Per Team")
                        Picker("Game Options", selection: $vm.gameOption) {
                            ForEach(vm.gameOptions, id: \.self) { option in
                                Text(String(option))
                            }
                        }
                        .padding(.horizontal)
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Divider()
                        .padding()
                    
                    Group{
                        VStack(alignment: .leading) {
                            Text("Home Team")
                            ForEach(0..<vm.gameOption, id: \.self) { index in
                                if let player = vm.homeTeam[index] {
                                    Text("\(player.firstName) \(player.lastName)")
                                        .modifier(PlayerPickModifier())
                                } else {
                                    Text("Empty Spot")
                                        .modifier(PlayerPickModifier())
                                        .opacity(0.2)
                                }
                            }
                            Button(action: {
                                vm.showingSheet = true
                                vm.currentTeam = .home
                            }, label: {
                                Text("Pick Players")
                                    .modifier(PlayerPickModifier())
                            })
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading) {
                            Text("Away Team")
                            ForEach(0..<vm.gameOption, id: \.self) { index in
                                if let player = vm.awayTeam[index] {
                                    Text("\(player.firstName) \(player.lastName)")
                                        .modifier(PlayerPickModifier())
                                } else {
                                    Text("Empty Spot")
                                        .modifier(PlayerPickModifier())
                                        .opacity(0.2)
                                }
                            }
                            Button(action: {
                                vm.showingSheet = true
                                vm.currentTeam = .away
                            }, label: {
                                Text("Pick Players")
                                    .modifier(PlayerPickModifier())
                            })
                        }
                    }
                    
                    Divider()
                        .padding()
                    
                    NavigationLink(
                        destination: GameView(homeTeam: Team(players: vm.homeTeam.compactMap({$0}), type: .home), awayTeam: Team(players: vm.awayTeam.compactMap({$0}), type: .away))
                    ) {
                        Text("Let's Go")
                            .modifier(GoButtonModifier())
                    }
                    .disabled(!vm.areTeamsFilled)
                    
                    Spacer()
                }
                .animation(.easeIn(duration: 0.5), value: vm.gameOption)
                
            }.scrollIndicators(.hidden)
            .padding(.horizontal)
            .sheet(isPresented: $vm.showingSheet, content: {
                sheetPickerView
            })
            .toolbar{
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Clear All Data"){
//                        do {
//                            try modelContext.delete(model: Player.self)
//                            try modelContext.delete(model: GameHistory.self)
//                        } catch {
//                            print("Failed to clear all data.")
//                        }
//                    }
//                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Clear Teams"){
                        for player in vm.homeTeam.compactMap({$0}){
                            player.inGame = false
                        }
                        for player in vm.awayTeam.compactMap({$0}){
                            player.inGame = false
                        }
                        vm.awayTeam = Array(repeating: nil, count: vm.gameOption)
                        vm.homeTeam = Array(repeating: nil, count: vm.gameOption)
                    }
                }
            }
            .navigationTitle("Set Up")
            .onAppear{
                vm.modelContext = modelContext
                vm.fetchPlayers()

                for player in vm.players {
                    if !vm.homeTeam.contains(where: { $0?.id == player.id }) &&
                       !vm.awayTeam.contains(where: { $0?.id == player.id }) {
                        player.inGame = false
                    } else {
                        player.inGame = true
                    }
                }

                for (index, player) in vm.awayTeam.enumerated() {
                    if let player = player, !vm.players.contains(where: { $0.id == player.id }) {
                        vm.awayTeam[index] = nil
                    }
                }
                vm.compactTeam(&vm.awayTeam)

            
                for player in vm.awayTeam.compactMap({$0}){
                    player.gamePoints = 0
                    player.gameAssists = 0
                    player.gameBlocks = 0
                    player.gameRebounds = 0
                    player.gameSteals = 0
                }

                for (index, player) in vm.homeTeam.enumerated() {
                    if let player = player, !vm.players.contains(where: { $0.id == player.id }) {
                        vm.homeTeam[index] = nil
                    }
                }
                vm.compactTeam(&vm.homeTeam)

                for player in vm.homeTeam.compactMap({$0}){
                    player.gamePoints = 0
                    player.gameAssists = 0
                    player.gameBlocks = 0
                    player.gameRebounds = 0
                    player.gameSteals = 0
                }
            }
        }
    }
    
    private var sheetPickerView: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField("Search player name", text: $vm.searchText)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .modifier(SearchBarModifier())
                .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(vm.filteredPlayers, id: \.id) { player in
                        VStack {
                            Button(action: {
                                vm.togglePlayerSelection(player)
                            }) {
                                HStack {
                                    if let photo = player.photo, let uiImage = UIImage(data:photo){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .modifier(ProfileImageModifier(size: 50))
                                    }else {
                                        CircleImage(picture: "avatar", size: 50)
                                    }
                                    Text(player.firstName + " " + player.lastName)
                                    Spacer()
                                    Text(player.position.map { $0.rawValue }.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                    if vm.isPlayerSelected(player) {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.blue)
                                    }
                                }
                                .padding()
                                .cornerRadius(8)
                            }
                            Divider()
                        }
                    }
                }
                .padding()
            }.scrollIndicators(.hidden)
        }
        .padding()
    }
}

#Preview {
    PlayView()
}
