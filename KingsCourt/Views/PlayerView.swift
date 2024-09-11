//
//  PlayerView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI
import PhotosUI
import SwiftUIImageViewer

struct PlayerView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = PlayerViewModel()
    var player: Player
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                if let photo = player.photo, let uiImage = UIImage(data:photo){
                    Image(uiImage: uiImage)
                        .resizable()
                        .modifier(ProfileImageModifier(size: 150))
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showingPhoto = true
                        }
                }else {
                    CircleImage(picture: "avatar", size: 150)
                        .shadow(radius: 10)
                }
              
                PhotosPicker(selection: $vm.selectedPhoto, matching: .images) {
                    Image(systemName: player.photo != nil ? "arrow.left.arrow.right": "plus")
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .offset(x: -10, y: 10)
                }
                .task(id: vm.selectedPhoto) {
                    if let data = try? await vm.selectedPhoto?.loadTransferable(type: Data.self){
                        vm.addImage(player: player, data: data)
                    }
                }
            }
        }
        .alert(isPresented: $vm.showingAlert){
            Alert(
                title: Text(vm.alertTitle),
                message: Text(vm.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear{
            vm.modelContext = modelContext
        }
        .fullScreenCover(isPresented: $vm.showingPhoto, content: {
            if let photo = player.photo, let uiImage = UIImage(data:photo){
                SwiftUIImageViewer(image: Image(uiImage: uiImage))
                    .overlay(alignment: .topTrailing) {
                        closeButton
                    }
            }
        })
        
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
                            
                            HStack {
                                Text("+/-")
                                Spacer()
                                Text(vm.showingTotals ? "\(player.plusMinus)" : vm.formattedStat(player.pmpg))
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
                    VStack{
                        HStack{
                            Text("Streak: \(player.streak)")
                            if player.streak != 0{
                                Image(systemName: player.streak > 0 ? "flame" : "snowflake")
                                    .foregroundStyle(player.streak > 0 ? .red : .blue)
                            }
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Text("\(player.wins) wins")
                                .foregroundStyle(Color.green)
                            Spacer()
                            Text("\(player.losses) losses")
                                .foregroundStyle(Color.red)
                        }
                    }
                  
                }
                Button {
                    vm.showingDeleteConfirm = true
                } label: {
                    Text("Delete Player")
                        .modifier(GoButtonModifier())
                        .foregroundStyle(.red)
                }
                .listRowBackground(Color.clear)
            }
            .confirmationDialog("Delete Player", isPresented: $vm.showingDeleteConfirm) {
                
                Button("Delete", role: .destructive){
                    if (vm.deletePlayer(player: player)){
                        dismiss()
                    }
                }
        
                Button("Cancel", role: .cancel) { }
            }
            

        }
       
    }
    
    private var closeButton: some View {
       Button {
           vm.showingPhoto = false
       } label: {
           Image(systemName: "xmark")
               .font(.headline)
       }
       .buttonStyle(.bordered)
       .clipShape(Circle())
       .tint(Color.accentColor)
       .padding()
   }
  
}

struct CircleImage: View {
    var picture: String
    var size: CGFloat
    
    var body: some View {
        Image(picture)
            .resizable()
            .modifier(ProfileImageModifier(size: size))
    }
}

#Preview {
    PlayerView(player: Player(id: UUID(), firstName: "Matthew", lastName: "Low", notes: "", position: [.PG, .SG]))
}
