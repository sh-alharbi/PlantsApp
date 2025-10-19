//
//  ContentView.swift
//  PlantsApp
//
//  Created by Shahad Alharbi on 10/19/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("GST")
                .imageScale(.large)
                .foregroundStyle(.tint)
                Text("Start your plant journey!🌿")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
