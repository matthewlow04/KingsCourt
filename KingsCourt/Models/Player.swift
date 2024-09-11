//
//  Player.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import Foundation
import SwiftData

@Model
class Player: ObservableObject, Identifiable, Equatable{
    var id: UUID
    var firstName: String
    var lastName: String
    var notes: String?
    var position: [Position]
    var points: Int = 0
    var assists: Int = 0
    var rebounds: Int = 0
    var steals: Int = 0
    var blocks: Int = 0
    var games: Int = 0
    var wins: Int = 0
    var losses: Int = 0
    var gamePoints: Int = 0
    var gameAssists: Int = 0
    var gameRebounds: Int = 0
    var gameSteals: Int = 0
    var gameBlocks: Int = 0
    var mvps: Int = 0
    var photo: Data?
    var streak: Int = 0
    var plusMinus: Int = 0
    
    var ppg: Double{
        return Double(points)/Double(games)
    }
    
    var apg: Double{
        return Double(assists)/Double(games)
    }
    
    var rpg: Double{
        return Double(rebounds)/Double(games)
    }
    
    var spg: Double{
        return Double(steals)/Double(games)
    }
    
    var bpg: Double{
        return Double(blocks)/Double(games)
    }
    
    var pmpg: Double{
        return Double(plusMinus)/Double(games)
    }
    
    var title: String{
        if games >= 25{
            return experienceTitle.veteran.rawValue
        } else if games >= 15{
            return experienceTitle.pro.rawValue
        } else if games >= 10{
            return experienceTitle.amateur.rawValue
        } else if games >= 5 {
            return experienceTitle.casual.rawValue
        } else {
            return experienceTitle.walkon.rawValue
        }
    }
    
    init(id: UUID, firstName: String, lastName: String, notes: String? = nil, position: [Position]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.notes = notes
        self.position = position
    }
    
    enum Position: String, Codable, CaseIterable {
        case PG = "PG"
        case SG = "SG"
        case SF = "SF"
        case PF = "PF"
        case C = "C"
        
        var description: String {
            switch self {
            case .PG: return "Point Guard"
            case .SG: return "Shooting Guard"
            case .SF: return "Small Forward"
            case .PF: return "Power Forward"
            case .C: return "Center"
            }
        }
    }
    
    enum experienceTitle: String, Codable{
        case walkon = "Walk-On"
        case casual = "Casual"
        case amateur = "Amateur"
        case pro = "Pro"
        case veteran = "Veteran"
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
}

extension Player{
    static var mockPlayers: [Player] = [
        .init(id: UUID(), firstName: "Matthew", lastName: "Low", position: [.PG, .SG]),
        .init(id: UUID(), firstName: "Kyrie", lastName: "Irving", position: [.PG]),
        .init(id: UUID(), firstName: "Steph", lastName: "Curry", position: [.PG, .SG]),
        .init(id: UUID(), firstName: "Iman", lastName: "Shumpert", position: [.SG, .SF]),
        .init(id: UUID(), firstName: "Lebron", lastName: "James", position: [.PG, .SF, .PF]),
        .init(id: UUID(), firstName: "John", lastName: "Wall", position: [.PG]),
        .init(id: UUID(), firstName: "Russell", lastName: "Westbrook", position: [.PG, .SG]),
        .init(id: UUID(), firstName: "Kyle", lastName: "Korver", position: [.SG, .SF]),
        .init(id: UUID(), firstName: "Giannis", lastName: "Antetokounmpo", position: [.PG, .SF, .PF])

    ]
}

