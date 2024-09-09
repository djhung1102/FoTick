//
//  TaskView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 28/7/24.
//

import SwiftUI
import SwiftData

struct TaskView: View {
    
    @Environment(FoTickManager.self) var fotickManager
    
    @State var isShowCreateTask: Bool = false
    @State var taskEdit: TaskModel?
    
    @Query(filter: #Predicate<TaskModel> { task in
        task.isDone == false
    }, animation: .easeInOut) var tasks: [TaskModel]
    
    var body: some View {
        NavigationStack {
            List {
                if tasks.count > 0 {
                    Section("Tasks") {
                        ForEach(tasks, id: \.id) { item in
                            TaskCard(task: item)
                                .padding(.vertical, 5)
                                .swipeActions {
                                    Button {
                                        fotickManager.deleteTask(task: item)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                    
                                    Button {
                                        taskEdit = item
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    .tint(.orange)
                                }
                        }
                    }
                } else {
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 5) {
                            Image(systemName: "tray")
                                .font(.system(size: 40))
                                .foregroundStyle(.brown)
                            
                            Text("No task found")
                                .font(.title3)
                                .foregroundStyle(.brown)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 50)
                }
                
                DoneTaskView()
                
            }
            .listStyle(.sidebar)
            .navigationTitle("To Do List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
//                    Text("PRO")
//                        .bold()
//                        .font(.footnote)
//                        .foregroundStyle(.white)
//                        .padding(.vertical, 6)
//                        .padding(.horizontal, 8)
//                        .background(.tint)
//                        .clipShape(.rect(cornerRadius: 16))
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: CategoryView()) {
                        Image(systemName: "folder.badge.plus")
                            .font(.system(size: 20))
                            .foregroundStyle(.gray)
                    }
                }
            }
            .overlay(alignment: .bottomTrailing) {
                Button {
                    print("Add new task")
                    isShowCreateTask.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                        .background(.tint)
                        .clipShape(.circle)
                }
                .padding(15)
            }
            .sheet(isPresented: $isShowCreateTask) {
                NavigationStack {
                    CreateTaskView()
                }
                .presentationDetents([.large])
            }
            .sheet(item: $taskEdit) {
                taskEdit = nil
            } content: { item in
                NavigationStack {
                    UpdateTaskView(task: item)
                }
                .presentationDetents([.large])
            }
        }
        .onAppear {
            if fotickManager.notificationAllowed {
                fotickManager.scheduleTaskCheckTimer()
            }
        }
        .onChange(of: fotickManager.notificationAllowed) { oldValue, newValue in
            if newValue == true {
                fotickManager.scheduleTaskCheckTimer()
            }
        }
    }
}

#Preview {
    TaskView()
}



