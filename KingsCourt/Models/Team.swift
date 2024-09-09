//
//  Team.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-07.
//

import Foundation

class Team: ObservableObject {
    @Published var players: [Player]
    @Published var points: Int
    var type: Team.Side
    
    init(players: [Player], type: Team.Side, points: Int = 0) {
        self.players = players
        self.type = type
        self.points = points
    }
    
    enum Side {
        case home
        case away
    }
}
