Planto!
Planto is a simple iOS app built using the MVVM architecture. It helps users take care of their plants by creating personalized reminders. Each reminder includes the plant’s name, room, light type, watering frequency, and water amount. The app tracks daily progress, lets users mark plants as watered, and sends local notifications when it’s time to water. It’s fully built with SwiftUI and Swift.

Architecture: MVVM

Model:

Models.swift -  Defines all plant-related data (PlantReminder, Room, Light, WateringFrequency, WaterAmount). Each model includes its own raw values, icons, and helper properties like isDoneToday.

ViewModel:

PlantReminderViewModel.swift - Handles logic for adding, editing, and saving reminders.

TodayRemindersViewModel.swift - Manages daily reminder logic and progress updates.

RemindersStore.swift - Observable object that stores all reminders and updates the UI automatically.

View:

ContentView.swift - Entry screen with app title and navigation to reminders. Used to add or edit plant reminders with fields for name, room, light, water, and frequency

TodayReminderPage.swift -  Displays all reminders, a daily progress bar, and lets users mark, edit, or delete reminders.

