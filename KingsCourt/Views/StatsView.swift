//
//  StatsView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//
import SwiftUI

struct StatsView: View {
    @StateObject var vm = StatsViewModel()
    @Environment(\.modelContext) var modelContext
    
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
                            
                            HStack (spacing: 15){
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
                                    .scaleEffect(vm.selectedPositions.contains(position) ? 1.5 : 1.3)
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
            .onAppear{
                vm.modelContext = modelContext
                vm.fetchPlayers()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                        Menu {
                            Picker("Sorting Options", selection: $vm.sortOption) {
                                Text("First Name").tag(0)
                                Text("Last Name").tag(1)
                                Text("Points").tag(2)
                                Text("Assists").tag(3)
                                Text("Rebounds").tag(4)
                                Text("Date Created").tag(5)
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
                                    if let photo = player.photo, let uiImage = UIImage(data:photo){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .modifier(ProfileImageModifier(size: 50))
                                    }else {
                                        CircleImage(picture: "avatar", size: 50)
                                    }
                                    VStack(alignment: .leading) {
                                        Text(player.firstName + " " + player.lastName)
                                            .lineLimit(1)
                                        Text(player.position.map { $0.rawValue }.joined(separator: ", "))
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                    Spacer()
                                    switch vm.sortOption{                         
                                    case 2:
                                        Text("\(vm.formattedStat(player.ppg)) ppg")
                                            .padding()
                                    case 3:
                                        Text("\(vm.formattedStat(player.apg)) apg")
                                            .padding()
                                    case 4:
                                        Text("\(vm.formattedStat(player.rpg)) rpg")
                                            .padding()
                                    default:
                                        Text("")
                                    }
                                }
                            }
                            Divider()
                        }
                        .foregroundStyle(.foreground)
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
