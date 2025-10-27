//
//  Untitled.swift
//  PlantsApp
//
//  Created by Shahad Alharbi on 10/22/25.
//

import SwiftUI

@MainActor
final class RemindersStore: ObservableObject {
    @Published var reminders: [PlantReminder] = []
    
    func add(_ reminder: PlantReminder) {
        reminders.append(reminder)
    }
    
    func update(_ updated: PlantReminder) {
           if let i = reminders.firstIndex(where: { $0.id == updated.id }) {
               reminders[i] = updated
           }
       }
    
    func delete(id: UUID) {
            if let i = reminders.firstIndex(where: { $0.id == id }) {
                reminders.remove(at: i)
            }
        }

    
    
}
