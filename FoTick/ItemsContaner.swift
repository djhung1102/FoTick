//
//  ItemsContaner.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 9/9/24.
//

import Foundation
import SwiftData

actor ItemsContaner {
    @MainActor
    static func create(isFirstTimeLaunch: inout Bool) -> ModelContainer {
        let schema = Schema([
            TaskModel.self,
            Category.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            let modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            if isFirstTimeLaunch {
                Category.defaults.forEach { category in
                    modelContainer.mainContext.insert(category)
                }
                isFirstTimeLaunch = false
            }
            return modelContainer
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
