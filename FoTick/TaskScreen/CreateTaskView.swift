//
//  CreateTaskView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 28/7/24.
//

import SwiftUI
import SwiftData

struct CreateTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(FoTickManager.self) var fotickManager
    
    @Query var categories: [Category]
    
    @State var task = Task()
    @State var selectedCategory: Category?
    
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
            
            Button("Create") {
                withAnimation {
                    fotickManager.saveTask(name: task.name, shortDescription: task.shortDescription, isDone: task.isDone, isImportant: task.isImportant, isNotification: task.isNotification, isSubTask: task.isSubTask, date: task.date)
                    
                    task.category = selectedCategory
                    selectedCategory?.tasks?.append(task)
                }
                
                dismiss()
            }
            .disabled(task.name.isEmpty)
        }
        .navigationTitle("Create Task")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }

            }
        }
    }
}

#Preview {
    CreateTaskView()
}
