//
//  PlayerViewModel.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-08.
//

import Foundation
import PhotosUI
import SwiftUI
import SwiftData

class PlayerViewModel: ObservableObject{
    @Published var showingTotals = false
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var showingPhoto = false
    @Published var showingDeleteConfirm = false
    var modelContext: ModelContext? = nil
    
    
    func formattedStat(_ stat: Double) -> String {
        String(format: "%.2f", stat)
    }
    
    func addImage(player: Player, data: Data){
        player.photo = data
    }
    
    func deletePlayer(player: Player){
        
        let fetchDescriptor = FetchDescriptor<GameHistory>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        
        let gameHistories = (try? (modelContext?.fetch(fetchDescriptor) ?? [])) ?? []
        
        let deletedPlayer = Player(id: UUID(), firstName: "Deleted", lastName: "Player", position: [])
        
        for gameHistory in gameHistories {
            for historyPlayer in gameHistory.awayTeam.players {
                if historyPlayer.player == player {
                    historyPlayer.player = deletedPlayer
                }
            }
            for historyPlayer in gameHistory.homeTeam.players {
                if historyPlayer.player == player {
                    historyPlayer.player = deletedPlayer
                }
            }
        }
        
        modelContext?.delete(player)
    }
    
}
