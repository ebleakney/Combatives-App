//
//  InitLogin.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/18/24.
//

import SwiftUI

struct InitLogin: View {
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            
            NavigationLink {
                SignInWithEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            } 
            NavigationLink {
                SignInWithEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10.0)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

struct InitLogin_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InitLogin(showSignInView: .constant(false))
        }
    }
}
