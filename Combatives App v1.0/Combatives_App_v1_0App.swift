//
//  Combatives_App_v1_0App.swift
//  Combatives App v1.0
//
//  Created by Ethan Bleakney on 1/11/24.
//

import SwiftUI
import Firebase


@main
struct Combatives_App_v1_0App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        

        return true
    }
}

