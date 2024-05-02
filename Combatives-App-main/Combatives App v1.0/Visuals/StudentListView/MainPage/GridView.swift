//
//  GridView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI

// TODO: Create the backend databast to store the references for the classes that are to be made

struct GridView: View {
    let columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<9) { item in
                    NavigationLink(destination: ClassView()) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(hue: Double(item) / 9.0, saturation: 0.3, brightness: 0.9))
                                .cornerRadius(12)
                            Text("Class \(item)")
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
