//
//  GameView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-08.
//

import SwiftUI

struct GameView: View {
    @StateObject var vm = GameViewModel()

    var body: some View {
        VStack{
            Divider()
            ScrollView{
                
                VStack(spacing: 10){
                    PlayerScoreView(player: Player.mockPlayers[0])
                  
                }
                .font(.subheadline)
            }.scrollIndicators(.hidden)
        
        
            VStack{
                HStack{
                    Text("Home")
                    Spacer()
                    Text("10")
                        .font(.system(size: 50))
                }
                HStack{
                    Text("Away")
                    Spacer()
                    Text("13")
                        .font(.system(size: 50))
                }
                
            }
            .font(.headline)

            ScrollView {
                VStack(spacing: 10){
                    PlayerScoreView(player: Player.mockPlayers[0])
                    PlayerScoreView(player: Player.mockPlayers[0])
                    PlayerScoreView(player: Player.mockPlayers[0])
                    PlayerScoreView(player: Player.mockPlayers[0])
                    PlayerScoreView(player: Player.mockPlayers[0])
                }
                .font(.subheadline)
            }.scrollIndicators(.hidden)
        
            Button(action: {}, label: {
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

struct PlayerScoreView: View{
    var player: Player
    var body: some View{
        HStack(spacing: 25){
            Text(player.firstName.prefix(1) + "." + player.lastName)
            
            Spacer()
            
            Button {

            } label: {
                VStack{
                    Text("Pts")
                    Text(String(player.gamePoints))
                }
            }

            Button {

            } label: {
                VStack{
                    Text("Ast")
                    Text(String(player.gameAssists))
                }
            }
            
            Button {

            } label: {
                VStack{
                    Text("Rbd")
                    Text(String(player.gameRebounds))
                }
            }
            
            Button {

            } label: {
                VStack{
                    Text("Stl")
                    Text(String(player.gameSteals))
                }
            }
            
            Button {

            } label: {
                VStack{
                    Text("Blk")
                    Text(String(player.gameBlocks))
                }
            }
        }
    }
}

#Preview {
    GameView()
}
