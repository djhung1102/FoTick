//
//  FoTickManager.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 28/7/24.
//

import Foundation
import SwiftData

@Observable class FoTickManager {
    
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func saveTask(name: String, shortDescription: String, isDone: Bool, isImportant: Bool, isNotification: Bool, isSubTask: Bool, date: Date) {
        do {
            let task = Task(name: name, shortDescription: shortDescription, isDone: isDone, isImportant: isImportant, isNotification: isNotification, isSubTask: isSubTask, date: date)
            
            modelContext.insert(task)
            
            try modelContext.save()
        } catch {
            print("Error Save Task")
        }
    }
    
    func deleteTask(task: Task) {
        do {
            modelContext.delete(task)
            
            try modelContext.save()
        } catch {
            print("Error Delete Task")
        }
    }
    
//    func updateTask(task: Task) {
//        do {
//            let fetchDescriptor = FetchDescriptor<Task>(
//                predicate: #Predicate { $0.id == task.id }
//            )
//            let existingTask = try modelContext.fetch(fetchDescriptor)
//            
//            if let existingTask = existingTask.first {
//                // Update existing Activity
//                existingTask.name = task.name
//                existingTask.shortDescription = task.shortDescription
//                existingTask.isDone = task.isDone
//                existingTask.isImportant = task.isImportant
//                existingTask.isNotification = task.isNotification
//                existingTask.isSubTask = task.isSubTask
//            }
//            
//            try modelContext.save()
//        } catch {
//            print("Error Update Task")
//        }
//    }
}
