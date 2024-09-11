//
//  AddPlayerView.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import SwiftUI

struct AddPlayerView: View {
    @StateObject var vm = AddPlayerViewModel()
    @Environment(\.modelContext) var modelContext
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Group{
                    HStack(spacing: 2){
                        Text("First Name")
                        Text(vm.firstName.isEmpty ? "*" : "")
                            .foregroundStyle(.red)
                    }
                    
                    TextField("First Name", text: $vm.firstName)
                        .modifier(FormTextfieldModifier())
                        .padding(.horizontal, 2)
                        .autocorrectionDisabled()
                }
               
                Group{
                    HStack(spacing: 2){
                        Text("Last Name")
                        Text(vm.lastName.isEmpty ? "*" : "")
                            .foregroundStyle(.red)
                    }
                    TextField("Last Name", text: $vm.lastName)
                        .modifier(FormTextfieldModifier())
                        .padding(.horizontal, 2)
                        .autocorrectionDisabled()
                }
                Group{
                    Text("Notes")
                    TextField("Notes", text: $vm.notes)
                        .modifier(FormTextfieldModifier())
                        .padding(.horizontal, 2)
                }
                Group{
                    HStack(spacing: 2){
                        Text("Positions")
                        Text(vm.positions.isEmpty ? "*" : "")
                            .foregroundStyle(.red)
                    }
                    HStack{
                        Spacer()
                        HStack {
                            ForEach(Player.Position.allCases, id: \.self) { position in
                                Button(action: {
                                    vm.togglePosition(position)
                                }) {
                                    Text(position.rawValue)
                                        .modifier(PickerCapsuleModifier())
                                        .opacity(vm.isPositionSelected(position) ? 1.0 : 0.3)
                                }
                            }
                        }
                        Spacer()
                    }
                }
                
                Spacer()
                Button {
                    vm.addPlayer()
                } label: {
                    Text("Add Player")
                        .modifier(GoButtonModifier())
                        .padding(.vertical)
                }
            }
            .padding(.horizontal)
            .navigationTitle("Add Player")
            .alert(isPresented: $vm.showingAlert){
                Alert(
                    title: Text("Success"),
                    message: Text(vm.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear{
                vm.modelContext = modelContext
            }
            .onDisappear{
                vm.clearFields()
            }
        }
    }
}


#Preview {
    AddPlayerView()
}
