//
//  AddPlayerViewModel.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-07.
//

import Foundation
import SwiftData

class AddPlayerViewModel: ObservableObject{
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var notes = ""
    @Published var positions: [Player.Position] = []
    @Published var showingAlert = false
    var alertMessage = ""
    var alertTitle = ""
    var modelContext: ModelContext? = nil

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
    
    func addPlayer(){
        if validateFields(){
            let player = Player(id: UUID(), firstName: firstName, lastName: lastName, notes: notes, position: positions)
            modelContext?.insert(player)
            alertTitle = "Success"
            alertMessage = "Player added"
            showingAlert = true
            clearFields()
        }
       
    }
    
    func validateFields() -> Bool{
        var missingFields = [String]()
        if firstName.isEmpty{
            missingFields.append("first name")
        }
        if lastName.isEmpty{
            missingFields.append("last name")
        }
        if positions.isEmpty{
            missingFields.append("position")
        }
        
        if missingFields.count > 1 {
            alertTitle = "Error"
            alertMessage = "More than one required field is missing"
            showingAlert = true
            return false
        }
        else if missingFields.count == 1{
            alertTitle = "Error"
            alertMessage = "Please enter a \(missingFields[0])"
            showingAlert = true
            return false
        }
        return true
    }
    
    func clearFields(){
        firstName = ""
        lastName = ""
        notes = ""
        positions.removeAll()
    }
    
}
