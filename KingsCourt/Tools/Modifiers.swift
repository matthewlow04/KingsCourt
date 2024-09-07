//
//  Modifiers.swift
//  KingsCourt
//
//  Created by Matthew Low on 2024-09-06.
//

import Foundation
import SwiftUI

struct SearchBarModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 10)
            .overlay{
                Capsule()
                    .stroke(lineWidth: 0.5)
                    .foregroundStyle(Color(.systemGray))
                    .shadow(color: .black.opacity(0.4), radius: 8)
            }
    }
}

struct PlayerPickModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).stroke(lineWidth: 1))

    }
}

struct GoButtonModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))

    }
}




 
