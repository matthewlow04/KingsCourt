//
//  GameView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-08.
//

import SwiftUI
import SwiftData

struct GameView: View {
    @StateObject var vm = GameViewModel()
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @StateObject var homeTeam: Team
    @StateObject var awayTeam: Team
    
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
                if homeTeam.points == awayTeam.points{
                    vm.alertTitle = "Tie"
                    vm.alertMessage = "Can't End On A Tie"
                    vm.showingAlert = true
                }else {
                    vm.finishGame()
                    vm.alertMessage = "GG!"
                    vm.alertTitle = "Game Over"
                    vm.showingAlert = true
                }
            }, label: {
                Text("Finish")
                    .modifier(GoButtonModifier())
            })

        }
        .padding()
        .navigationTitle("King's Court")
        .alert(isPresented: $vm.showingAlert){
            Alert(
                title: Text(vm.alertTitle),
                message: Text(vm.alertMessage),
                dismissButton: .default(Text("OK")){
                    if(vm.gameOver){
                        dismiss()
                    }
                }
            )
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    vm.isAdding.toggle()
                }) {
                    Image(systemName: vm.isAdding ? "plus" : "minus")
                }
            }
        }
        .onAppear{
            vm.gameOver = false
            if vm.homeTeam == nil && vm.awayTeam == nil {
                vm.modelContext = modelContext
                vm.homeTeam = homeTeam
                vm.awayTeam = awayTeam
                vm.clearStats()
            }
            for player in awayTeam.players{
                player.inGame = true
            }
            
            for player in homeTeam.players{
                player.inGame = true
            }
        }
        .onDisappear{
//            vm.clearStats()
        }
    }
}



struct PlayerScoreView: View {
    @StateObject var player: Player
    @StateObject var team: Team
    @StateObject var vm: GameViewModel
    
    var body: some View {
        HStack(spacing: 25) {
            Text(player.firstName.prefix(1) + "." + player.lastName)
                .lineLimit(1)
            
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
