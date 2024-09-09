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
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TaskModel.self,
            Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//            let modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
//            Category.defaults.forEach { category in
//                modelContainer.mainContext.insert(category)
//            }
//            return modelContainer
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
