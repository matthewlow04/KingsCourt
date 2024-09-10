//
//  ContentView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            PlayView()
                .tabItem{Label("Play", systemImage: "basketball.fill")}
            AddPlayerView()
                .tabItem{Label("Add Player", systemImage: "person.fill.badge.plus")}
            StatsView()
                .tabItem{Label("Stats", systemImage: "chart.bar.fill")}
            GameLogView()
                .tabItem{Label("Game Log", systemImage: "scroll.fill")}
        }
    }
}

#Preview {
    ContentView()
}
