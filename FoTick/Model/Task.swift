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
class TaskModel {
    @Attribute(.unique) var id: UUID
    var name: String
    var shortDescription: String
    var isDone: Bool
    var isImportant: Bool
    var isNotification: Bool
    var isSubTask: Bool
    var date: Date
    var updatedAt: Date
    
    @Relationship(deleteRule: .nullify, inverse: \Category.tasks)
    var category: Category?
    
    init(id: UUID = UUID(), name: String = "", shortDescription: String = "", isDone: Bool = false, isImportant: Bool = false, isNotification: Bool = false, isSubTask: Bool = false, date: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.isDone = isDone
        self.isImportant = isImportant
        self.isNotification = isNotification
        self.isSubTask = isSubTask
        self.date = date
        self.updatedAt = Date()
    }
}

extension TaskModel {
    static var defaults: [TaskModel] {
        [
            .init(name: "Create task", shortDescription: "This is create task", isDone: false, isImportant: false, isNotification: false, isSubTask: false, date: Date()),
            .init(name: "Create task 2", shortDescription: "This is create task 2", isDone: false, isImportant: false, isNotification: false, isSubTask: false, date: Date()),
        ]
    }
}
