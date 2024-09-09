//
//  PlayerView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI

struct PlayerView: View {
    @StateObject var vm = PlayerViewModel()
    var player: Player
    var body: some View {
        VStack{
            ZStack(alignment: .bottomTrailing){
                CircleImage(picture: "avatar")
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .offset(x: -10, y: 10)
            }
           
        }
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                HStack(alignment: .center){
                    VStack(alignment: .leading){
                        Text(player.firstName + " " + player.lastName)
                            .font(.largeTitle)
                        Text(player.position.map { $0.rawValue }.joined(separator: " "))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text(player.title)
                        Text(player.games == 1 ? "\(player.games) game played" : "\(player.games) games played")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }
            }
            .padding()
           
            Form{
                Section{
                    List{
                        Section{
                            HStack{
                                Text("Points")
                                Spacer()
                                Text(vm.showingTotals ? "\(player.points) points" : "\(player.ppg) ppg")
                            }
                            HStack{
                                Text("Assists")
                                Spacer()
                                Text(vm.showingTotals ? "\(player.assists) assists" : "\(player.apg) apg")
                            }
                            HStack{
                                Text("Rebounds")
                                Spacer()
                                Text(vm.showingTotals ? "\(player.rebounds) rebounds" : "\(player.rpg) rpg")
                            }
                            HStack{
                                Text("Steals")
                                Spacer()
                                Text(vm.showingTotals ? "\(player.steals) steals" : "\(player.spg) spg")
                            }
                            HStack{
                                Text("Blocks")
                                Spacer()
                                Text(vm.showingTotals ? "\(player.blocks) blocks" : "\(player.bpg) bpg")
                            }


                        }
                    }
                } header: {
                    HStack{
                        Text(vm.showingTotals ? "Totals" : "Averages")
                        Spacer()
                        Toggle(isOn: $vm.showingTotals){}
                            .toggleStyle(.switch)
                    }
                }
                Section{
                    HStack{
                        Text("\(player.wins) wins")
                        Spacer()
                        Text("\(player.losses) losses")
                    }
                }
            }
        }
    }
}

struct CircleImage: View {
    var picture: String
    var body: some View {
          Image(picture)
            .resizable()
            .frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fit)
                     .clipShape(Circle())
                     .overlay(Circle().stroke(Color.white, lineWidth: 2))
                     .shadow(radius: 10)
    }
}





#Preview {
    PlayerView(player: Player(id: UUID(), firstName: "Matthew", lastName: "Low", notes: "", position: [.PG, .SG]))
}
