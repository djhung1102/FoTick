//
//  UpdateTaskView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 29/7/24.
//

import SwiftUI
import SwiftData

struct UpdateTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(FoTickManager.self) var fotickManager
    
    @Query var categories: [Category]
    @State var selectedCategory: Category?
    
    @Bindable var task: TaskModel
    
    var body: some View {
        List {
            Section("To Do Title") {
                TextField("Title", text: $task.name)
            }
            
            Section {
                DatePicker("Date", selection: $task.date)
                
                Toggle("Important?", isOn: $task.isImportant)
            }
            
            Section("Select a category") {
                Picker("", selection: $selectedCategory) {

                    ForEach(categories) { category in
                        HStack {
                            Image(systemName: category.icon)
                                .foregroundColor(Color(category.color))
                            
                            Text(category.name)
                        }
                        .tag(category as Category?)
                    }

                    Text("None")
                        .tag(nil as Category?)
                }
                .labelsHidden()
                .pickerStyle(.inline)
            }
            
            Button("Update") {
                task.category = selectedCategory
                dismiss()
            }
        }
        .navigationTitle("Create Task")
        .onAppear {
            selectedCategory = task.category
        }
    }
}

#Preview {
    UpdateTaskView(task: TaskModel(id: UUID(), name: "Task 1", shortDescription: "Short description", isDone: false, isImportant: false, isNotification: false, isSubTask: false, date: Date()))
}
