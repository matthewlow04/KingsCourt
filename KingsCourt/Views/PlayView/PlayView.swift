//
//  PlayView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI

struct PlayView: View {
    
    @StateObject var vm = PlayViewModel()
    
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
                                    Text(player.firstName + " " + player.lastName)
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
                                    Text(player.firstName + " " + player.lastName)
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
                    
                    NavigationLink(destination: GameView()) {
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
            .navigationTitle("Set Up")
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
                                    Text(player.firstName + " " + player.lastName)
                                    Spacer()
                                    Text(player.position.map { $0.rawValue }.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    if vm.isPlayerSelected(player) {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
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
