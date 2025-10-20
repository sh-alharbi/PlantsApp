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

            VStack() {
                Text("My Plants 🌱")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(x: -70 , y: 10)

                Divider()
                    .overlay(Color.white)
            }
           
            
            VStack{
                Image("GST")
                    .frame(width: 315, height: 330)
               
            }
            
            
            VStack{
                
                Text("Start your plant journey!")
                //.font(.custom("SFPro-Semibold", size: 25))
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 273, height: 30, alignment: .center)
            }

            Spacer()
                .frame(height: 25)
            

            VStack{
                Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                            //.font(.custom("SFPro-Regular", size: 16))
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color(red: 159/255, green: 159/255, blue: 145/255))
                    .opacity(0.7)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            Button("Set Plant Reminder") {
            }
            .background(Color.white)

        }
    }
}

#Preview {
    ContentView()
}
