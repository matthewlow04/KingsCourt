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
            .backgroundStyle(Color.accentColor)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))

    }
}

struct FormTextfieldModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5))

    }
}

struct PickerCapsuleModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 60)
            .background(Capsule().stroke(lineWidth: 0.5))
    }
}

struct ProfileImageModifier: ViewModifier{
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))

    }
}



 
