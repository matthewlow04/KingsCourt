//
//  Team.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-07.
//

import Foundation

class Team{
    var players: [Player]
    var type: Team.Side
    
    init(players: [Player], type: Team.Side) {
        self.players = players
        self.type = type
    }
    
    enum Side{
        case home
        case away
    }
}
