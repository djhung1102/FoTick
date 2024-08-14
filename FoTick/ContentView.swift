//
//  ContentView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 28/7/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(FoTickManager.self) var fotickManager
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            TaskView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Setting")
                }
                .tag(2)
        }
        .onAppear {
            Task {
                await fotickManager.requestNotification()
            }
        }
    }
}

#Preview {
    ContentView()
}
