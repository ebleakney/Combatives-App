//
//  SidebarContentView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 4/23/24.
//

import SwiftUI

//this view just displays the stuff in the sidebar, and is used in HomeScreen.swift as the navigationsplitview content
// that shows up when the sidebar icon is clicked
struct SidebarContentView: View {
    @Binding var selection: SidebarSelection?
    var body: some View {
        SidebarView(selection: $selection)
            .navigationBarHidden(true)
    }
}

