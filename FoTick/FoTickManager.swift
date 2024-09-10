//
//  FoTickManager.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 28/7/24.
//

import Foundation
import SwiftData
import UserNotifications
import NotificationCenter

@Observable class FoTickManager {
    let center = UNUserNotificationCenter.current()
    
    var modelContext: ModelContext
    var notificationAllowed: Bool = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        checkNotificationAuthorizationStatus()
    }
    
    var doneTasks: [TaskModel] = []
    var notDoneTasks: [TaskModel] = []
    
    func saveTask(name: String, shortDescription: String, isDone: Bool, isImportant: Bool, isNotification: Bool, isSubTask: Bool, date: Date) {
        do {
            let task = TaskModel(name: name, shortDescription: shortDescription, isDone: isDone, isImportant: isImportant, isNotification: isNotification, isSubTask: isSubTask, date: date)
            
            modelContext.insert(task)
            
            try modelContext.save()
        } catch {
            print("Error Save Task")
        }
    }
    
    func deleteTask(task: TaskModel) {
        do {
            modelContext.delete(task)
            
            try modelContext.save()
        } catch {
            print("Error Delete Task")
        }
    }
    
    func fetchTasks(for date: Date) {
        do {
            let fetchDescriptor = FetchDescriptor<TaskModel>(
                predicate: #Predicate { $0.isDone == true }
            )
            
            let existingTask = try modelContext.fetch(fetchDescriptor)
            
            DispatchQueue.main.async {
                self.doneTasks = existingTask
            }
            
        } catch {
            print("Error Update Task")
        }
    }
    
    func fetchTasksNotDone(for date: Date) {
        do {
            let fetchDescriptor = FetchDescriptor<TaskModel>(
                predicate: #Predicate { $0.isDone == false }
            )
            
            let existingTask = try modelContext.fetch(fetchDescriptor)
            
            DispatchQueue.main.async {
                self.notDoneTasks = existingTask
            }
            
        } catch {
            print("Error Update Task")
        }
    }
    
    // Yêu cầu cấp quyền thông báo cho ứng dụng
    func requestNotification() async {
        do {
            try await center.requestAuthorization(options: [.alert, .sound, .badge])
            
            notificationAllowed = true
            scheduleDailyNotification()
        } catch {
            print(error)
        }
    }
    
    func checkNotificationAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                    case .denied:
                        self.notificationAllowed = false
                    case .authorized, .provisional, .ephemeral:
                        self.notificationAllowed = true
                    default:
                        self.notificationAllowed = true
                }
            }
        }
    }
    
    @MainActor
    func openSettingsNotificationInIOS() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                Task {
                    await UIApplication.shared.open(url)
                }
            }
        }
    }
    
    func getNotificationSetting() async {
        let settings = await center.notificationSettings()
        // Verify the authorization status.
        guard (settings.authorizationStatus == .authorized) ||
                (settings.authorizationStatus == .provisional) else { return }
        
        if settings.alertSetting == .enabled {
            // Schedule an alert-only notification.
        } else {
            // Schedule a notification with a badge and sound.
        }
    }
    
    func scheduleDailyNotification() {
        print("Schedule Daily Notification")
        let content = UNMutableNotificationContent()
        content.title = "Plan Your Day"
        content.body = "It's 8 AM! Time to plan your day."
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(for task: TaskModel) {
        // Tạo nội dung thông báo
        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = "Don't forget to complete the task: \(task.name)"
        content.sound = .default

        // Xác định thời gian thông báo (ví dụ sau 10 giây)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10800, repeats: false)

        // Tạo yêu cầu thông báo
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Thêm thông báo vào trung tâm thông báo
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    func scheduleTaskCheckTimer() {
        // Tính thời gian còn lại đến 5 giờ chiều
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = 17
        
        if let nextTriggerDate = calendar.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .nextTime) {
            let timeInterval = nextTriggerDate.timeIntervalSinceNow
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
                self.checkTasksAndSendNotification()
                self.scheduleTaskCheckTimer() // Lên lịch lại cho ngày hôm sau
            }
        }
    }
    
    func checkTasksAndSendNotification() {
        do {
            let fetchDescriptor = FetchDescriptor<TaskModel>(
                predicate: #Predicate { $0.isDone != true}
            )
            
            let existingTask = try modelContext.fetch(fetchDescriptor)
            
            // Kiểm tra danh sách task
            if existingTask.count > 0 {
                let content = UNMutableNotificationContent()
                content.title = "Pending Tasks"
                content.body = "You have unfinished tasks. Please check your task list."
                content.sound = UNNotificationSound.default
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
                
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    }
                }
            }
            
        } catch {
            print("Error Update Task")
        }
        
    }
    
    // Cancel notifications with identifier
    public func removeNotificationWithIdentifiers(id: [String]) {
        center.removePendingNotificationRequests(withIdentifiers: id)
    }
    
    // Cancel all notifications
    public func removeAllNotification() {
        center.removeAllPendingNotificationRequests()
    }
    
    
}

