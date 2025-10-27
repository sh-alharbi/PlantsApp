//
//  Models.swift
//  PlantsApp
//
//  Created by Shahad Alharbi on 10/22/25.
//
import SwiftUI

extension Light {
    var iconName: String {
        switch self {
        case .fullSun:    return "sun.max.fill"
        case .partialSun: return "sun.haze.fill"
        case .lowLight:   return "moon.fill"
        }
    }
    var color: Color {
        switch self {
        case .fullSun:    return Color(red: 204/255, green: 199/255, blue: 133/255)
        case .partialSun:  return Color(red: 204/255, green: 199/255, blue: 133/255)
        case .lowLight:    return Color(red: 204/255, green: 199/255, blue: 133/255)
        }
    }
}

enum Room: String, CaseIterable, Identifiable {
    case bedroom = "Bedroom", livingRoom = "Living Room", kitchen = "Kitchen", balcony = "Balcony", bathroom = "Bathroom"
    var id: String { rawValue }
}

enum Light: String, CaseIterable, Identifiable {
    case fullSun = "Full Sun", partialSun = "Partial Sun", lowLight = "Low Light"
    var id: String { rawValue }
}

enum WateringFrequency: String, CaseIterable, Identifiable {
    case everyDay = "Every day", every2Days = "Every 2 days", every3Days = "Every 3 days",
         onceAWeek = "Once a week", every10Days = "Every 10 days", every2Weeks = "Every 2 weeks"
    var id: String { rawValue }
}

enum WaterAmount: String, CaseIterable, Identifiable {
    case a20_50 = "20-50 ml", a50_100 = "50-100 ml", a100_200 = "100-200 ml", a200_300 = "200-300 ml"
    var id: String { rawValue }
}

struct PlantReminder: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var room: Room
    var light: Light
    var frequency: WateringFrequency
    var amount: WaterAmount
    var lastCompletedAt: Date? = nil
    
    var isDoneToday: Bool {
            guard let d = lastCompletedAt else { return false }
            return Calendar.current.isDateInToday(d)
        }
}


