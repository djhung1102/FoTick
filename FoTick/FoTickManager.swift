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
    
    var doneTasks: [Task] = []
    
    func saveTask(name: String, shortDescription: String, isDone: Bool, isImportant: Bool, isNotification: Bool, isSubTask: Bool, date: Date) {
        print("Save Task")
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
    
    func fetchTasks(for date: Date) {
        do {
            let fetchDescriptor = FetchDescriptor<Task>(
                predicate: #Predicate { $0.isDone == true }
            )
            
            let existingTask = try modelContext.fetch(fetchDescriptor)
            
            DispatchQueue.main.async {
                self.doneTasks = existingTask
            }
            
//            try modelContext.save()
        } catch {
            print("Error Update Task")
        }
    }
}
