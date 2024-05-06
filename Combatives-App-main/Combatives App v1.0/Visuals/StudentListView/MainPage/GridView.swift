//
//  GridView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI
import Combine

@MainActor
class GridViewViewModel: ObservableObject {
    @Published var classes = [DBClass]()

    init() {
        fetchClasses()
    }

    func fetchClasses() {
        Task {
            do {
                let snapshot = try await ClassManager.shared.classCollection.getDocuments()
                self.classes = snapshot.documents.compactMap { document in
                    try? document.data(as: DBClass.self)
                }
            } catch {
                print("Error fetching classes: \(error)")
            }
        }
    }
}


struct GridView: View {
    @StateObject private var viewModel = GridViewViewModel()
    let columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.classes, id: \.classId) { dbClass in
                    NavigationLink(destination: ClassView(dbClass: dbClass)) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color(hue: Double.random(in: 0...1), saturation: 0.3, brightness: 0.9))
                                .cornerRadius(12)
                            Text(dbClass.className ?? "Unnamed Class")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

