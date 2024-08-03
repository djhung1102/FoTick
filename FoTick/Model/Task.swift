//
//  Task.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 28/7/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Task {
    @Attribute(.unique) var id: UUID
    var name: String
    var shortDescription: String
    var isDone: Bool
    var isImportant: Bool
    var isNotification: Bool
    var isSubTask: Bool
    var date: Date
    var updatedAt: Date
    
    @Relationship(deleteRule: .cascade, inverse: \SubTask.tasks)
    var subTasks: [SubTask]?
    
    @Relationship(deleteRule: .nullify, inverse: \Category.tasks)
    var category: Category?
    
    init(id: UUID = UUID(), name: String = "", shortDescription: String = "", isDone: Bool = false, isImportant: Bool = false, isNotification: Bool = false, isSubTask: Bool = false, date: Date = Date(), updatedAt: Date = Date(), subTasks: [SubTask]? = nil) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.isDone = isDone
        self.isImportant = isImportant
        self.isNotification = isNotification
        self.isSubTask = isSubTask
        self.date = date
        self.updatedAt = Date()
        self.subTasks = subTasks
    }
}

@Model
class SubTask {
    @Attribute(.unique) var id: UUID
    var name: String
    var isDone: Bool
    var date: Date
    var tasks: [Task]?
    
    init(id: UUID = UUID(), name: String = "", isDone: Bool = false, isImportant: Bool = false, isFavorite: Bool = false, isNotification: Bool = false, date: Date = Date(), tasks: [Task]? = nil) {
        self.id = id
        self.name = name
        self.isDone = isDone
        self.date = date
        self.tasks = tasks
    }
}
