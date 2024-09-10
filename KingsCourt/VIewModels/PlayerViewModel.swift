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
    var modelContext: ModelContext? = nil
    
    
    func formattedStat(_ stat: Double) -> String {
        String(format: "%.2f", stat)
    }
    
    func addImage(player: Player, data: Data){
        player.photo = data
    }
}
