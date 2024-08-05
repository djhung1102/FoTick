//
//  CalendarView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 5/8/24.
//

import SwiftUI

struct CalendarView: View {
    
    @Environment(FoTickManager.self) var fotickManager
    @State var selectedDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .labelsHidden()
                    .onChange(of: selectedDate) { oldValue, newValue in
                        fotickManager.fetchTasks(for: selectedDate)
                    }
                
                List {
                    Section(header: Text("Done")) {
                        ForEach(fotickManager.doneTasks) { task in
                            if Calendar.current.isDate(task.updatedAt, inSameDayAs: selectedDate) {
                                TaskCard(task: task)
                                    .padding(.vertical, 3)
                            }
                        }
                    }
                }
            }
            .onAppear {
                fotickManager.fetchTasks(for: selectedDate)
            }
        }
    }
}

#Preview {
    CalendarView()
}
