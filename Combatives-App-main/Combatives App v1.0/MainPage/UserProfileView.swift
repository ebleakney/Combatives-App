//
//  UserProfileView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        Button(action: {
            // Profile button action
        }) {
            HStack {
                Text("Jess Militar")
                Image(systemName: "person.crop.circle.fill")
            }
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
