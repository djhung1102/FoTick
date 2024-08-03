//
//  DoneTaskView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 3/8/24.
//

import SwiftUI
import SwiftData

struct DoneTaskView: View {
    
    @Environment(FoTickManager.self) var fotickManager
    
    @Query(filter: #Predicate<Task> {
        $0.isDone
    }, animation: .easeInOut) var doneTasks: [Task] = []
    
    var body: some View {
        if doneTasks.count > 0 {
            Section("Done") {
                ForEach(doneTasks, id: \.id) { item in
                    if Calendar.current.isDate(item.updatedAt, inSameDayAs: Date()) {
                        TaskCard(task: item)
                            .padding(.vertical, 5)
                    }
                }
            }
        }
    }
}

#Preview {
    DoneTaskView()
}
