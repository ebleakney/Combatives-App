//
//  InitLogin.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/18/24.
//

import SwiftUI

struct InitLogin: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    @Binding var showSignInView: Bool
    @Binding var showSignUpView: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("USAFA Combatives App")
                    .font(.largeTitle) // Adjust font size to closely match navigationTitle
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading) // Align to the left
                    .padding() // Add padding to match typical navigationTitle spacing
                Image("Combatives-221101-F-XS730-1008")
                    .padding(.bottom, 20)
                    .cornerRadius(10.0)
                
                Button("Sign In") {
                    showSignInView = true
                    showSignUpView = false
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
                    showSignInView = false
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
        }
        .padding()
    }
}

struct InitLogin_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InitLogin(showSignInView: .constant(false), showSignUpView: .constant(false))
                .environmentObject(AppViewModel())
        }
    }
}
