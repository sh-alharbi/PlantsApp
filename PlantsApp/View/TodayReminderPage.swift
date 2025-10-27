//
//  TodayReminderPage.swift
//  PlantsApp
//
//  Created by Shahad Alharbi on 10/21/25.
//

import SwiftUI

struct TodayReminderPage: View {
    @EnvironmentObject var store: RemindersStore
    @StateObject private var vm = TodayRemindersViewModel()
    @State private var showReminderSheet = false
    @State private var editingReminder: PlantReminder? = nil

    var body: some View {
        ZStack(alignment: .bottomTrailing) {

            VStack(alignment: .leading, spacing: 12) {
                VStack {
                    Text("My Plants 🌱")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                }

                Spacer().frame(height: 6)

                let doneCount  = store.reminders.filter { $0.isDoneToday }.count
                let totalCount = store.reminders.count
                let progress   = totalCount == 0 ? 0 : Double(doneCount) / Double(totalCount)
                let allDone    = totalCount > 0 && doneCount == totalCount

                if !allDone {
                    HStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Text(doneCount == 0
                                 ? "Your plants are waiting for a sip 💧"
                                 : "\(doneCount) of your plants feel loved today ✨")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.85))
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)

                            ProgressView(value: progress)
                                .progressViewStyle(.linear)
                                .tint(Color(red: 102/255, green: 254/255, blue: 208/255))
                                .frame(width: 361, height: 8)
                                .scaleEffect(y: 3.0, anchor: .center)
                                .mask(RoundedRectangle(cornerRadius: 4))
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(red: 38/255, green: 38/255, blue: 38/255))
                                )
                        }
                        .frame(width: 361)
                        Spacer()
                    }

                    Spacer().frame(height: 10)
                }

                if allDone {
                    AllDoneView()
                } else {
                    List {
                        ForEach(store.reminders) { r in
                            HStack(alignment: .center, spacing: 12) {

                                Button {
                                    store.toggleDoneToday(for: r.id)
                                } label: {
                                    Image(systemName: r.isDoneToday ? "checkmark.circle.fill" : "circle")
                                        .font(.system(size: 25, weight: .semibold))
                                        .foregroundColor(
                                            r.isDoneToday
                                            ? Color(red: 102/255, green: 254/255, blue: 208/255)
                                            : .gray.opacity(0.6)
                                        )
                                }
                                .buttonStyle(.plain)

                                VStack(alignment: .leading, spacing: 6) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "location")
                                            .font(.system(size: 11))
                                            .foregroundColor(.gray)
                                        Text("in \(r.room.rawValue)")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }

                                    Text(r.name)
                                        .font(.system(size: 22, weight: .semibold))
                                        .foregroundColor(.white)

                                    HStack(spacing: 8) {
                                        PillBadge(
                                            text: r.light.rawValue,
                                            icon: r.light.iconName,
                                            color: r.light.color,
                                            backgroundColor: Color(red: 24/255, green: 24/255, blue: 29/255)
                                        )
                                        PillBadge(
                                            text: r.amount.rawValue,
                                            icon: "drop.fill",
                                            color: Color(red: 202/255, green: 243/255, blue: 251/255),
                                            backgroundColor: Color(red: 24/255, green: 24/255, blue: 29/255)
                                        )
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture { editingReminder = r }
                            }
                            .padding(.vertical, 10)
                            .opacity(r.isDoneToday ? 0.45 : 1.0)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        store.delete(id: r.id)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }

                                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                    Button {
                                        store.toggleDoneToday(for: r.id)
                                    } label: {
                                        Label(r.isDoneToday ? "Undo" : "Done", systemImage: r.isDoneToday ? "arrow.uturn.left" : "checkmark")
                                    }
                                    .tint(Color(red: 102/255, green: 254/255, blue: 208/255))
                                }
                            
                        }
                    }
                    .listStyle(.plain)
                    .listRowSeparator(.hidden)
                }
            }

            Button {
                showReminderSheet = true
            } label: {
                ZStack {
                    Circle()
                        .fill(Color(red: 102/255, green: 254/255, blue: 208/255))
                    Image(systemName: "plus")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                }
                .frame(width: 48, height: 48)
                .glassEffect(.regular.interactive(), in: Circle())
            }
            .buttonStyle(.plain)
            .padding(24)
        }

        .sheet(isPresented: $showReminderSheet) {
            PlantReminderSheet(
                viewModel: PlantReminderViewModel(),
                onSaved: { _ in showReminderSheet = false },
                onDelete: nil
            )
            .environmentObject(store)
        }

        .sheet(item: $editingReminder) { item in
            PlantReminderSheet(
                viewModel: PlantReminderViewModel(existing: item),
                onSaved: { updated in
                    store.update(updated)
                },
                onDelete: { id in
                    store.delete(id: id)
                }
            )
            .environmentObject(store)
        }

        .navigationBarBackButtonHidden(true)
    }
}

struct PillBadge: View {
    var text: String
    var icon: String
    var color: Color
    var backgroundColor: Color = Color(red: 24/255, green: 24/255, blue: 29/255)

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(color)
            Text(text)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(color)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Capsule().fill(backgroundColor))
    }
}

extension RemindersStore {
    func toggleDoneToday(for id: UUID) {
        guard let idx = reminders.firstIndex(where: { $0.id == id }) else { return }
        let now = Date()
        if Calendar.current.isDateInToday(reminders[idx].lastCompletedAt ?? .distantPast) {
            reminders[idx].lastCompletedAt = nil
        } else {
            reminders[idx].lastCompletedAt = now
        }
    }
}

struct AllDoneView: View {
    var body: some View {
        VStack(spacing: 14) {
            Image("PlantMascotWink")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)

            Text("All Done! 🎉")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)

            Text("All reminders completed")
                .font(.caption)
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.horizontal, 24)
    }
}
