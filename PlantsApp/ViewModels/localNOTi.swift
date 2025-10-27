//
//  NotificationManager.swift
//  PlantsApp
//
//  Created by Shahad Alharbi on 10/26/25.
//

import Foundation
import UserNotifications
import UIKit

final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    private override init() { super.init() }

    func askPermission() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification auth error:", error.localizedDescription)
                return
            }
            print(granted ? "Access granted ✅" : "Access denied ❌")
        }
    }

    func scheduleEvery24Hours(id: String = "waterPlants24h",
                              firstAfter seconds: TimeInterval = 10) {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let’s water your plant"
        content.sound = .default

        let firstTrigger = UNTimeIntervalNotificationTrigger(timeInterval: max(60, seconds), repeats: false)
        let firstRequest = UNNotificationRequest(identifier: id + "_first", content: content, trigger: firstTrigger)

        let dailyTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 24 * 60 * 60, repeats: true)
        let repeatRequest = UNNotificationRequest(identifier: id, content: content, trigger: dailyTrigger)

        let center = UNUserNotificationCenter.current()
        center.add(firstRequest) { error in
            if let error = error { print("First notification error:", error.localizedDescription) }
        }
        center.add(repeatRequest) { error in
            if let error = error { print("Repeat notification error:", error.localizedDescription) }
        }
    }

    func cancel(id: String = "waterPlants24h") {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id, id + "_first"])
    }

    func cancelAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .sound])
    }
    func scheduleDailyAt(hour: Int, minute: Int, id: String, title: String, body: String) {
        var date = DateComponents()
        date.hour = hour
        date.minute = minute

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { err in
            if let err = err { print("scheduleDailyAt error:", err.localizedDescription) }
        }
    }
}
