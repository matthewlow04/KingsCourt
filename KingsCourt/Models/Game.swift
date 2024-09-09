//
//  Game.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-08.
//

import Foundation

class Game: ObservableObject {
    @Published var homeTeam: Team
    @Published var awayTeam: Team
    
    init(homeTeam: Team, awayTeam: Team) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
}
