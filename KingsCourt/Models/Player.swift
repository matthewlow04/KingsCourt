//
//  Player.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import Foundation
import SwiftData


@Model
class Player{
    var id: UUID
    var name: String
    var notes: String?
    var position: [Position]
    
    init(id: UUID, name: String, notes: String? = nil, position: [Position]) {
        self.id = id
        self.name = name
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
    
   
    
}

extension Player{
    static var mockPlayers: [Player] = [
        .init(id: UUID(), name: "Matthew", position: [.PG, .SG]),
        .init(id: UUID(), name: "Marcus", position: [.PG, .SG]),
        .init(id: UUID(), name: "Phil", position: [.SF, .C]),
        .init(id: UUID(), name: "Terry", position: [.PG, .SG]),
        .init(id: UUID(), name: "Spencer", position: [.PG, .SG]),
        .init(id: UUID(), name: "Lebron", position: [.SF, .PF]),
        .init(id: UUID(), name: "Kyrie", position: [.PG, .SG]),
        .init(id: UUID(), name: "Kyle", position: [.PG, .SG]),
        .init(id: UUID(), name: "George", position: [.SF, .C]),
        .init(id: UUID(), name: "Paul", position: [.SF, .C])
    ]
}

