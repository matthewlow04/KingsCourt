//
//  GameHistory.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-07.
//

import Foundation

class GameHistory{
    var awayTeam: Team
    var homeTeam: Team
    var date: Date
    var id = UUID()
    
    init(awayTeam: Team, homeTeam: Team, date: Date) {
        self.awayTeam = awayTeam
        self.homeTeam = homeTeam
        self.date = date
    }
}
