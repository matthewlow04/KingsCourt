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
        VStack {
            ZStack(alignment: .bottomTrailing) {
                CircleImage(picture: "avatar")
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .offset(x: -10, y: 10)
            }
        }
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(player.firstName + " " + player.lastName)
                            .font(.largeTitle)
                        Text(player.position.map { $0.rawValue }.joined(separator: " "))
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(player.title)
                            .foregroundStyle(.gray)
                        Text(player.games == 1 ? "\(player.games) game played" : "\(player.games) games played")
                            .foregroundStyle(.gray)
                        Text("MVPS: \(player.mvps)")
                            .foregroundStyle(Color.accentColor)
                    }
                    .font(.caption)
                  
                }
            }
            .padding()
           
            Form {
                Section {
                    List {
                        Section {
                            HStack {
                                Text("Points")
                                Spacer()
                                Text(vm.showingTotals ? "\(player.points)" : vm.formattedStat(player.ppg))
                            }
                            HStack {
                                Text("Assists")
                                Spacer()
                                Text(vm.showingTotals ? "\(player.assists)" : vm.formattedStat(player.apg))
                            }
                            HStack {
                                Text("Rebounds")
                                Spacer()
                                Text(vm.showingTotals ? "\(player.rebounds)" : vm.formattedStat(player.rpg))
                            }
                            HStack {
                                Text("Steals")
                                Spacer()
                                Text(vm.showingTotals ? "\(player.steals)" : vm.formattedStat(player.spg))
                            }
                            HStack {
                                Text("Blocks")
                                Spacer()
                                Text(vm.showingTotals ? "\(player.blocks)" : vm.formattedStat(player.bpg))
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text(vm.showingTotals ? "Totals" : "Averages")
                        Spacer()
                        Toggle(isOn: $vm.showingTotals) {}
                            .toggleStyle(.switch)
                    }
                }
                Section {
                    HStack {
                        Text("\(player.wins) wins")
                            .foregroundStyle(Color.green)
                        Spacer()
                        Text("\(player.losses) losses")
                            .foregroundStyle(Color.red)
                    }
                }
            }
        }
    }
    
    // Helper method to format averages with two decimal places
  
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
