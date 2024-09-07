//
//  AddPlayerViewModel.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-07.
//

import Foundation

class AddPlayerViewModel: ObservableObject{
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var notes = ""
    @Published var positions: [Player.Position] = []

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
}
