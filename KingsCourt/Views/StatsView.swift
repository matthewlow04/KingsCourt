//
//  StatsView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//
import SwiftUI

struct StatsView: View {
    @StateObject var vm = StatsViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        VStack(alignment: .leading, spacing: 2) {
                            TextField("Search by Name", text: $vm.searchText)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .autocorrectionDisabled(true)
                            
                            HStack {
                                Text("Filters: ")
                                
                                ForEach(Player.Position.allCases, id: \.self) { position in
                                    Button {
                                        if vm.selectedPositions.contains(position) {
                                            vm.selectedPositions.removeAll { $0 == position }
                                        } else {
                                            vm.selectedPositions.append(position)
                                        }
                                    } label: {
                                        Text(position.rawValue)
                                    }
                                    .scaleEffect(vm.selectedPositions.contains(position) ? 1.3 : 1.1)
                                    .foregroundStyle(vm.selectedPositions.contains(position) ? Color.accentColor : .gray)
                                }
                            }
                            .font(.caption)
                            .foregroundStyle(.gray)
                        }
                    }
                    .padding(3)
                    .padding(.vertical, 7)
                    .background(RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 0.5))
                    
                    Spacer()
                    
                    
                }
                .padding(.horizontal)
                
               
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                        Menu {
                            Picker("Sorting Options", selection: $vm.sortOption) {
                                Text("First Name").tag(0)
                                Text("Last Name").tag(1)
                                Text("Assists").tag(2)
                                Text("Rebounds").tag(3)
                                Text("Date Created").tag(4)
                            }
                        }
                        label: {
                            VStack{
                                Text("Sort Type")
                            }
                            
                        }
                        
                        Button {
                            vm.sortDescending.toggle()
                        } label: {
                            Image(systemName: vm.sortDescending ? "arrow.down" : "arrow.up")
                        }
                        .animation(.easeIn, value: vm.sortDescending)
                    }
                }
            }
            
            ScrollView {
                VStack {
                    ForEach(vm.sortedPlayers) { player in
                        VStack {
                            NavigationLink(destination: PlayerView(player: player)){
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(player.firstName + " " + player.lastName)
                                        Text(player.position.map { $0.rawValue }.joined(separator: ", "))
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                            }
                            Divider()
                        }
                    }
                }
                .animation(.easeIn, value: vm.sortedPlayers)
            }
            .padding()
            .navigationTitle("Stats")
        }
    }
}

#Preview {
    StatsView()
}
