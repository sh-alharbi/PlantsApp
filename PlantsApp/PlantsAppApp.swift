//
//  PlantsAppApp.swift
//  PlantsApp
//
//  Created by Shahad Alharbi on 10/19/25.
//

import SwiftUI

@main
struct PlantsAppApp: App {
    @StateObject private var store = RemindersStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store) 
                .preferredColorScheme(.dark)
        }
    }
}


