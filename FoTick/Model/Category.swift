//
//  Category.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 28/7/24.
//

import Foundation
import SwiftData

@Model
class Category {
    @Attribute(.unique) var id: UUID
    var name: String
    var icon: String
    var color: String
    var tasks: [TaskModel]?
    
    init(id: UUID = UUID(), name: String = "", icon: String = "", color: String = "", tasks: [TaskModel]? = nil) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
        self.tasks = tasks
    }
}
