//
//  ContentView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 28/7/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(FoTickManager.self) var fotickManager
    @Environment(\.modelContext) var modelContext
    
    @State private var isFirstLaunch: Bool = {
        let hasLaunched = UserDefaults.standard.bool(forKey: "hasLaunched")
        return !hasLaunched
    }()
    
    @AppStorage("isFirstLaunchSave") var isFirstLaunchSave: Bool = true
    
    @State var selection = 0
    
    var body: some View {
        ZStack {
            if isFirstLaunch {
                TodolistOn(isFirstLaunch: $isFirstLaunch)
                    .transition(.move(edge: .trailing))
            } else {
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
                    
                    PomodoroView()
                        .tabItem {
                            Image(systemName: "timer")
                            Text("Pomodoro")
                        }
                        .tag(2)
                    
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gearshape.fill")
                            Text("Setting")
                        }
                        .tag(3)
                }
                .transition(.move(edge: .leading))
                .onAppear {
                    if isFirstLaunchSave {
                        Category.defaults.forEach { category in
                            modelContext.insert(category)
                        }
                        isFirstLaunchSave = false
                    }
                    Task {
                        await fotickManager.requestNotification()
                    }
                }
            }
        }
        .animation(.easeInOut, value: isFirstLaunch)
    }
}

//#Preview {
//    ContentView()
//}
