//
//  InitLogin.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/18/24.
//

import SwiftUI

struct InitLogin: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var showSignInView = false
    @State private var showSignUpView = false
    
    var body: some View {
        VStack {
            Text("Sign In")
                .font(.largeTitle) // Adjust font size to closely match navigationTitle
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading) // Align to the left
                .padding() // Add padding to match typical navigationTitle spacing
            Image("Combatives-221101-F-XS730-1008")
                .padding(.bottom, 20)
                .cornerRadius(10.0)
            
            Button("Sign In") {
                showSignInView = true
            }
            .fullScreenCover(isPresented: $showSignInView) {
                SignInWithEmailView()
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10.0)

            Button("Sign Up") {
                showSignUpView = true
            }
            .fullScreenCover(isPresented: $showSignUpView) {
                SignUpWithEmailView()
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10.0)
        }
        
//        NavigationStack {
//            NavigationLink {
//                SignInWithEmailView()
//                    .environmentObject(appViewModel)
//            } label: {
//                Text("Sign In")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(height: 55)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(10.0)
//            }
//            NavigationLink {
//                SignUpWithEmailView()
//                    .environmentObject(appViewModel)
//            } label: {
//                Text("Sign Up")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .frame(height: 55)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(10.0)
//            }
//            
//            Spacer()
//        }
        .padding()
    }
}

struct InitLogin_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InitLogin()
                .environmentObject(AppViewModel())
        }
    }
}
