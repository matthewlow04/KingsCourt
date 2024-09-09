//
//  PlayViewModel.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import Foundation
import SwiftUI

class PlayViewModel: ObservableObject {
    @Published var showingSheet = false
    @Published var homeTeam: [Player?] = [nil]
    @Published var awayTeam: [Player?] = [nil]
    @Published var searchText = ""
    @Published var currentTeam = Team.home
    @Published var gameOption = 1 {
        didSet {
            resizeTeams(to: gameOption)
        }
    }
    
    var gameOptions = [1, 2, 3, 4, 5]

    private func resizeTeams(to size: Int) {
        homeTeam = Array(homeTeam.prefix(size) + Array(repeating: nil, count: max(0, size - homeTeam.count)))
        awayTeam = Array(awayTeam.prefix(size) + Array(repeating: nil, count: max(0, size - awayTeam.count)))
    }
    
    var filteredPlayers: [Player] {
        let unavailablePlayers = (currentTeam == .home ? awayTeam : homeTeam).compactMap { $0 }
        return Player.mockPlayers.filter { player in
            (searchText.isEmpty || player.firstName.localizedCaseInsensitiveContains(searchText) || player.lastName.localizedCaseInsensitiveContains(searchText))
            &&
            !unavailablePlayers.contains(where: { $0.id == player.id })
        }
    }
    
    var areTeamsFilled: Bool {
        return homeTeam.allSatisfy { $0 != nil } && awayTeam.allSatisfy { $0 != nil }
    }

    enum Team {
        case away
        case home
    }

    func togglePlayerSelection(_ player: Player) {
        switch currentTeam {
        case .home:
            if let index = homeTeam.firstIndex(where: { $0?.id == player.id }) {
                homeTeam[index] = nil
                compactTeam(&homeTeam)
            } else if homeTeam.filter({ $0 != nil }).count < gameOption {
                if let index = homeTeam.firstIndex(where: { $0 == nil }) {
                    homeTeam[index] = player
                }
            }
        case .away:
            if let index = awayTeam.firstIndex(where: { $0?.id == player.id }) {
                awayTeam[index] = nil
                compactTeam(&awayTeam)
            } else if awayTeam.filter({ $0 != nil }).count < gameOption {
                if let index = awayTeam.firstIndex(where: { $0 == nil }) {
                    awayTeam[index] = player
                }
            }
        }
    }
    
    func isPlayerSelected(_ player: Player) -> Bool {
        switch currentTeam {
        case .home:
            return homeTeam.contains(where: { $0?.id == player.id })
        case .away:
            return awayTeam.contains(where: { $0?.id == player.id })
        }
    }
    
    private func compactTeam(_ team: inout [Player?]) {
        team = team.compactMap { $0 } + Array(repeating: nil, count: gameOption - team.compactMap { $0 }.count)
    }
}
