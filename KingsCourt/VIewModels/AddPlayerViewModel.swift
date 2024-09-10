//
//  AddPlayerViewModel.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-07.
//

import Foundation
import SwiftData

class AddPlayerViewModel: ObservableObject{
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var notes = ""
    @Published var positions: [Player.Position] = []
    var modelContext: ModelContext? = nil

    func togglePosition(_ position: Player.Position) {
        if positions.contains(position) {
            positions.removeAll { $0 == position }
        } else {
            positions.append(position)
        }
    }

    func isPositionSelected(_ position: Player.Position) -> Bool {
        positions.contains(position)
    }
    
    func addPlayer(){
        let player = Player(id: UUID(), firstName: firstName, lastName: lastName, position: positions)
        modelContext?.insert(player)
    }
    
    
}
