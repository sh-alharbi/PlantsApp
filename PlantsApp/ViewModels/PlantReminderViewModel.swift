//
//  PlantReminderViewModel.swift
//  PlantsApp
//
//  Created by Shahad Alharbi on 10/22/25.
//
import SwiftUI

@MainActor
final class PlantReminderViewModel: ObservableObject {
    @Published var plantName: String = ""
    @Published var selectedRoom: Room = .bedroom
    @Published var selectedLight: Light = .fullSun
    @Published var selectedFrequency: WateringFrequency = .everyDay
    @Published var selectedAmount: WaterAmount = .a20_50

    let rooms = Room.allCases
    let lights = Light.allCases
    let frequencies = WateringFrequency.allCases
    let amounts = WaterAmount.allCases

    private(set) var editingId: UUID? = nil

    init() {}

    convenience init(existing r: PlantReminder) {
        self.init()
        self.editingId = r.id
        self.plantName = r.name
        self.selectedRoom = r.room
        self.selectedLight = r.light
        self.selectedFrequency = r.frequency
        self.selectedAmount = r.amount
    }

    @discardableResult
    func save(into store: RemindersStore) -> PlantReminder {
        if let id = editingId, let i = store.reminders.firstIndex(where: { $0.id == id }) {
            var u = store.reminders[i]
            u.name = plantName.isEmpty ? "no name" : plantName
            u.room = selectedRoom
            u.light = selectedLight
            u.frequency = selectedFrequency
            u.amount = selectedAmount
            store.reminders[i] = u
            return u
        } else {
            let n = PlantReminder(
                name: plantName.isEmpty ? "no name" : plantName,
                room: selectedRoom,
                light: selectedLight,
                frequency: selectedFrequency,
                amount: selectedAmount
            )
            store.add(n)
            return n
        }
    }
}
