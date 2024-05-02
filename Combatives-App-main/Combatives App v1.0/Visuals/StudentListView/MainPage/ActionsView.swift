//
//  ActionsView.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 4/23/24.
//

// Actions view is meant for the teacher to be able to add classes
// in the app, and be able to upload files
//(like student roster excel files)
import SwiftUI

@MainActor
final class ActionsViewModel: ObservableObject {
    @Published var student: DBStudent? = nil
}

struct ActionsView: View {
    @StateObject private var viewModel = ActionsViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: AddClassView()) {
                Text("Add Class Manually")
                }
                .padding()
                Text("or")
                    .padding()
                Button("Upload files to generate classes -- NOT FUNCTIONAL") {
                }
            }
        }
    }
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ActionsView()
    }
}
