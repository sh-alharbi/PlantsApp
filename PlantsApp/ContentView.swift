//
//  ContentView.swift
//  PlantsApp
//
//  Created by Shahad Alharbi on 10/19/25.
//

import SwiftUI

struct ContentView: View {
    @State var showPlantReminderSheet = false
    
    var body: some View {
        NavigationStack{
            
            VStack {
                VStack{
                    Text("My Plants 🌱")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                    
                    Divider()
                        .overlay(Color.white)
                }
                
                VStack{
                    Image("PlantMascot")
                        .frame(width: 315, height: 330 , alignment: .center)
                        .padding(.bottom, -37)
                }
                
                VStack{
                    Text("Start your plant journey!")
                        .font(.custom("SFPro-Semibold", size: 25))
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 273, height: 30, alignment: .center)
                    
                    Spacer()
                        .frame(height: 25)
                }
                
                VStack{
                    Text("Now all your plants will be in one place and \n we will help you take care of them :)🪴")
                        .font(.custom("SFPro-Regular", size: 16))
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color(red: 159/255, green: 159/255, blue: 145/255))
                        .opacity(0.7)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                
                VStack{
                    Button("Set Plant Reminder") {
                        showPlantReminderSheet.toggle()
                    }
                    .sheet(isPresented: $showPlantReminderSheet) {
                        PlantReminderSheet()
                        
                    }
                    .font(.custom("SFPro-Medium", size: 17))
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 280, height: 44)
                    .background(
                        Capsule().fill(
                            Color(red: 102/255, green: 254/255, blue: 208/255))
                    )
                    
                    // spacing check it out
                    // Spacer().frame(height: 122)
                    Spacer().frame(height: 70)
                }
            }
        }
    }
    
    struct PlantReminderSheet: View {
        
        @Environment(\.dismiss) var dismiss
        @State var PlantName = ""
        
        @State var selectedRoom = 0
        @State var selectedlights = 0
        @State var selectedDays = 0
        @State var selectedWaterType = 0

        var rooms: [String] = ["Bedroom", "Living Room", "Kitchen", "Balcony" ,"Bathroom" ]
        var lights: [String] = ["􀆭 Full Sun" , "􀆷 Partial Sun" , "􀆹 Low Light "]
        var days: [String] = ["Every day" , "Every 2 days" , "Every 3 days" ,"Once a week" , "Every 10 days" ,"Every 2 weeks"  ]
        var WaterType: [String] = ["20-50 ml" , "50-100 ml" , "100-200 ml", "200-300 ml"]
       
        
        var body: some View {
            VStack  {
                
                
                HStack (spacing: 83){
                    
                    Button(action: { dismiss() }) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.black.opacity(0.4),
                                                 Color(red: 26/255, green: 26/255, blue: 26/255)],
                                        startPoint: .top, endPoint: .bottom
                                    )
                                )
                            
                            Circle()
                                .stroke(Color(red: 38/255, green: 38/255, blue: 38/255), lineWidth: 1)
                                .blur(radius: 0.25)
                                .mask(
                                    Circle().fill(
                                        LinearGradient(colors: [.black, .clear],
                                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                )
                            
                            Circle()
                                .stroke(Color(red: 77/255, green: 77/255, blue: 77/255), lineWidth: 1)
                                .blur(radius: 0.25)
                                .offset(x: 2, y: 2)
                                .mask(
                                    Circle().fill(
                                        LinearGradient(colors: [.clear, .black],
                                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                                    )
                                )
                            
                            
                            Image(systemName: "xmark")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 23 , height: 20)
                        }
                        .frame(width: 44, height: 44)
                    }
                    
                    
                    
                    VStack{
                        Text("Set Reminder")
                            .font(.custom("SFPro-Semibold" ,size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 108 , height: 22 , alignment: .center)
                        
                    }
                    
                    
                    ZStack {
                        NavigationLink(destination: TodayReminderPage()) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 102/255, green: 254/255, blue: 208/255))
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 1)
                                            .blur(radius: 0.25)
                                            .blendMode(.overlay)
                                    )
                                    .opacity(0.45)
                                
                                Image(systemName: "checkmark")
                                    .font(.system(size: 17, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: 23 , height: 20)
                            }
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                        }
                    }
                    
                    
                    
                    
                }
                .padding(.top, 12)
                Spacer()
                
                
                
                
                
                Form{
                    Section{
                        LabeledContent("Plant Name" ){
                            TextField(" ", text: $PlantName)
                            
                        }
                        
                        
                    }
                    
                    Section {
                        LabeledContent {
                            Picker("", selection: $selectedRoom) {
                                ForEach(0..<rooms.count, id: \.self) { i in
                                    Text(rooms[i])
                                }
                            }
                            .pickerStyle(.menu)
                            
                        } label: {
                            Label("Room", systemImage: "location")
                                .symbolRenderingMode(.monochrome)
                        }
                    }

                        
                        Picker(selection: $selectedlights , label: Text("􀆭 light")) {
                            ForEach(0..<lights.count, id: \.self){
                                Text(self.lights[$0])
                            }
                            
                        }
                        
                    }
                    
                    
                    
                    
                    Section{
                        Picker(selection: $selectedDays , label: Text("􀋑 Room")) {
                            ForEach(0..<rooms.count, id: \.self){
                                Text(self.rooms[$0])
                            }
                            
                        }
                        
                        Picker(selection: $selectedRoom , label: Text("􀆭 light")) {
                            ForEach(0..<rooms.count, id: \.self){
                                Text(self.rooms[$0])
                            }
                        }
                        
                        
                        
                        
                    }
                }
            }
        }
    }


#Preview {
    ContentView()
}
