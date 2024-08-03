//
//  FoTickApp.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 28/7/24.
//

import SwiftUI
import SwiftData

@main
struct FoTickApp: App {
    
    var sharedModelContainer: ModelContainer = {
            let schema = Schema([
                Task.self,
                SubTask.self,
                Category.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
        .environment(FoTickManager(modelContext: sharedModelContainer.mainContext))
    }
}
