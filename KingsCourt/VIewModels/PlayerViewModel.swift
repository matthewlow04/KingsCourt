//
//  PlayerViewModel.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-08.
//

import Foundation

class PlayerViewModel: ObservableObject{
    @Published var showingTotals = false
    
    func formattedStat(_ stat: Double) -> String {
        String(format: "%.2f", stat)
    }
}
