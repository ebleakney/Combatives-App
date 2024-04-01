//
//  MainContentView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI

struct MainContentView: View {
    @Binding var selection: SidebarSelection?
    var body: some View {
        SidebarView(selection: $selection)
            .navigationBarHidden(true)
    }
}
