//
//  GridView.swift
//  Combatives App v1.0
//
//  Created by James Huber on 2/15/24.
//

import SwiftUI
import Combine

struct GridView: View {
    @StateObject private var viewModel = GridViewViewModel()
    let columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    @State private var showingDeleteConfirmation = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.classes, id: \.classId) { dbClass in
                                if viewModel.isSelectionMode {
                                    selectionView(for: dbClass)
                                } else {
                                    NavigationLink(destination: ClassView(dbClass: dbClass)) {
                                        classView(for: dbClass)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .confirmationDialog("Are you sure you want to delete these classes?", isPresented: $showingDeleteConfirmation, actions: {
                    Button("Delete", role: .destructive) {
                        viewModel.confirmDeletion()
                    }
                    Button("Cancel", role: .cancel) {}
                })
                
                // Control buttons positioned as per selection mode
                if viewModel.isSelectionMode {
                    selectionButtons
                        .transition(.move(edge: .trailing))
                        .padding()
                } else {
                    selectClassesButton
                        .transition(.move(edge: .trailing))
                        .padding()
                }
            }
        }
    }

    @ViewBuilder
    private func classView(for dbClass: DBClass) -> some View {
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

    @ViewBuilder
    private func selectionView(for dbClass: DBClass) -> some View {
        classView(for: dbClass)
            .overlay(
                Rectangle()
                    .stroke(viewModel.selectedClasses.contains(dbClass.classId) ? Color.red : Color.clear, lineWidth: 5)
            )
            .onTapGesture {
                viewModel.toggleSelection(classId: dbClass.classId)
            }
    }
    
    private var selectClassesButton: some View {
        Button(action: {
            viewModel.enterSelectionMode()
        }) {
            Label("Select Classes", systemImage: "pencil.circle")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                //.clipShape(Circle())
                .shadow(radius: 5)
        }
    }
    
    private var selectionButtons: some View {
        HStack {
            Button("Cancel Selection") {
                viewModel.cancelSelectionMode()
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)

            Button("Delete Selected Classes") {
                showingDeleteConfirmation = true
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}






