//
//  DetailView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI

struct DetailView: View {
    let selection: Int
    var body: some View {
        Text("Detail view for selection \(selection)")
        RearMountView()
    }
}
