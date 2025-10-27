//
//  ContentView.swift
//  PlantsApp
//
//  Created by Shahad Alharbi on 10/19/25.
//

import SwiftUI

struct ContentView: View {
    @State var showPlantReminderSheet = false
    @State private var goToToday = false

    var body: some View {
        NavigationStack {
            VStack {

                VStack {
                    Text("My Plants 🌱")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)

                    Divider()
                        .overlay(Color.white)
                }

                VStack {
                    Image("PlantMascot")
                        .frame(width: 315, height: 330, alignment: .center)
                        .padding(.bottom, -37)
                }

                VStack {
                    Text("Start your plant journey!")
                        .font(.custom("SFPro-Semibold", size: 25))
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 273, height: 30, alignment: .center)

                    Spacer()
                        .frame(height: 25)
                }

                VStack {
                    Text("Now all your plants will be in one place and \nwe will help you take care of them :)🪴")
                        .font(.custom("SFPro-Regular", size: 16))
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(red: 159/255, green: 159/255, blue: 145/255))
                        .opacity(0.7)
                        .multilineTextAlignment(.center)

                    Spacer()
                }

                VStack {
                    Button("Set Plant Reminder") {
                        showPlantReminderSheet.toggle()
                    }
                    .sheet(isPresented: $showPlantReminderSheet) {
                        PlantReminderSheet(
                            viewModel: PlantReminderViewModel(),
                            onSaved: { _ in
                                goToToday = true
                            }
                        )
                    }
                    .font(.custom("SFPro-Medium", size: 17))
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 280, height: 44)
                    .background(
                        Capsule().fill(
                            Color(red: 102/255, green: 254/255, blue: 208/255)
                        )
                    )
                    .glassEffect(.regular.interactive())

                    Spacer()
                        .frame(height: 70)
                }
            }
            .navigationDestination(isPresented: $goToToday) {
                TodayReminderPage()
            }
        }
    }
}


struct PlantReminderSheet: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: RemindersStore
    @ObservedObject var viewModel: PlantReminderViewModel

    var onSaved: (PlantReminder) -> Void
    var onDelete: ((UUID) -> Void)? = nil

    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 83) {
                    Button(action: { dismiss() }) {
                        ZStack {
                            Circle()
                                .fill(Color.black.opacity(0.4))
                            Image(systemName: "xmark")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 23, height: 20)
                        }
                        .frame(width: 44, height: 44)
                        .glassEffect(.regular.interactive(), in: Circle())
                    }
                    .buttonStyle(.plain)

                    Text("Set Reminder")
                        .font(.custom("SFPro-Semibold", size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 108, height: 22, alignment: .center)

                    Button {
                        let saved = viewModel.save(into: store)
                        let notiId = "water_\(saved.id.uuidString)"
                        NotificationManager.shared.cancel(id: notiId)
                        NotificationManager.shared.scheduleEvery24Hours(
                            id: notiId,
                            firstAfter: 60 // اذا ابي اغير الاشعار وقته اغيره هنا
                        )

                        onSaved(saved)
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color(red: 102/255, green: 254/255, blue: 208/255))
                            Image(systemName: "checkmark")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 44, height: 44)
                        .glassEffect(.regular.interactive(), in: Circle())
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 12)

                Spacer()

                Form {
                    Section {
                        LabeledContent("Plant Name") {
                            TextField(" ", text: $viewModel.plantName)
                        }
                    }

                    Section {
                        LabeledContent {
                            Picker("", selection: $viewModel.selectedRoom) {
                                ForEach(viewModel.rooms) { r in
                                    Text(r.rawValue).tag(r)
                                }
                            }
                        } label: {
                            Label("Room", systemImage: "location")
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(.white)

                        }

                        Picker(selection: $viewModel.selectedLight) {
                            ForEach(viewModel.lights) { l in
                                Label(
                                    l.rawValue,
                                    systemImage: l == .fullSun
                                    ? "sun.max.fill"
                                    : (l == .partialSun ? "sun.haze" : "moon")
                                )
                                .foregroundStyle(.white)
                                .labelStyle(.titleAndIcon)
                                .tag(l)
                            }
                            } label: {
                            Label("Light", systemImage: "sun.max")
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(.white)

                        }
                    }

                    Section {
                        LabeledContent {
                            Picker("", selection: $viewModel.selectedFrequency) {
                                ForEach(viewModel.frequencies) { f in
                                    Text(f.rawValue).tag(f)
                                }
                            }
                        } label: {
                            Label("Watering Days", systemImage: "drop")
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(.white)

                        }

                        Picker(selection: $viewModel.selectedAmount) {
                            ForEach(viewModel.amounts) { a in
                                Text(a.rawValue).tag(a)
                            }
                        } label: {
                            Label("Water", systemImage: "drop")
                                .symbolRenderingMode(.monochrome)
                                .foregroundStyle(.white)

                        }
                    }

                    if let id = viewModel.editingId {
                        Section {
                            Button(role: .destructive) {
                                onDelete?(id)
                                dismiss()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Delete Reminder")
                                    Spacer()
                                }
                            }
                        }
                    }
                }

            }
            .navigationBarTitleDisplayMode(.inline)
            
            .onAppear {
                        NotificationManager.shared.askPermission()
                    }
        }
        

    }
}

#Preview {
    ContentView()
        .environmentObject(RemindersStore())
        .preferredColorScheme(.dark)
}
