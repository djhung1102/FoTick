//
//  TaskCard.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 28/7/24.
//

import SwiftUI

struct TaskCard: View {
    
    let task: Task
    
    var body: some View {
        HStack {
            HStack {
                if task.isDone {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 24))
                }
                
                VStack(alignment: .leading, spacing: 1) {
                    Text(task.name)
                        .font(.title3)
                        .foregroundStyle(task.isDone ? .gray : .black)
                        .strikethrough(task.isDone ? true : false, color: task.isDone ? .gray : .black)
                    
//                    Text(task.date.formatted(date: .numeric, time: .omitted))
//                        .font(.caption)
//                        .foregroundStyle(.gray)
                }
            }
            .onTapGesture {
                task.isDone.toggle()
            }
            
            Spacer()
            
            Image(systemName: task.isImportant ? "flag.fill" : "flag")
                .foregroundStyle(task.isImportant ? .red : .blue)
                .font(.system(size: 24))
        }
    }
}

#Preview {
    TaskCard(task: Task(id: UUID(), name: "Task 1", shortDescription: "Short description", isDone: false, isImportant: false, isNotification: false, isSubTask: false, date: Date(), subTasks: nil))
}
