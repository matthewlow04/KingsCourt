//
//  GameLogView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI

struct GameLogView: View {
    var gameHistory = GameHistory(awayTeam: Team(players: [Player.mockPlayers[0], Player.mockPlayers[1]], type: .away), homeTeam: Team(players: [Player.mockPlayers[0], Player.mockPlayers[1]], type: .home), date: Date.now)
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView{
                    VStack(alignment: .leading){
                        Text("Sep 7 2024")
                        Text("ID: asdlfasdfsadfsadf")
                            .font(.footnote)
                            .opacity(0.3)
                            .padding(.bottom)
                        VStack{
                            HStack{
                                Text("Away")
                                    .font(.headline)
                                Image(systemName: "medal.fill")
                                    .foregroundStyle(.green)
                                Spacer()
                                Text("21")
                                    .font(.largeTitle)
                            }
                            Group{
                                HStack{
                                    Text("Matthew")
                                    Image(systemName: "crown.fill")
                                        .foregroundStyle(.yellow)
                                    Spacer()
                                    Text("10")
                                }
                                HStack{
                                    Text("Phil")
                                    Spacer()
                                    Text("6")
                                }
                                HStack{
                                    Text("Kelvin")
                                    Spacer()
                                    Text("5")
                                }
                            }
                            .font(.subheadline)
                           
                        }
                        Divider()
                            .padding()
                        VStack{
                            HStack{
                                Text("Home")
                                    .font(.headline)
                                Spacer()
                                Text("13")
                                    .font(.largeTitle)
                            }
                            Group{
                                HStack{
                                    Text("Mark")
                                    Spacer()
                                    Text("7")
                                }
                                HStack{
                                    Text("Jerry")
                                    Spacer()
                                    Text("3")
                                }
                                HStack{
                                    Text("Lent")
                                    Spacer()
                                    Text("3")
                                }
                            }
                            .font(.subheadline)
                          
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(style: StrokeStyle(lineWidth: 0.5, dashPhase: 2.0)))
                    .padding()
                    
                }
            }
            .navigationTitle("Game History")
        }
    }
}

#Preview {
    GameLogView()
}
