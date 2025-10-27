//
//  T.swift
//  PlantsApp
//
//  Created by Shahad Alharbi on 10/22/25.
//

import SwiftUI

@MainActor
final class TodayRemindersViewModel: ObservableObject {
    @Published private(set) var reminders: [PlantReminder] = []
    
    func bind(to store: RemindersStore) {
        reminders = store.reminders
    }
}
