//
//  PomodoroManager.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 10/9/24.
//

import Foundation
import SwiftUI

@Observable class PomodoroManager {
    var progress: CGFloat = 1
    var timerStringValue: String = "00:00"
    var isStarted: Bool = false
    var addNewTimer: Bool = false
    
    var hour: Int = 0
    var minutes: Int = 0
    var second: Int = 0
    
    var totalSeconds: Int = 0
    var staticTotalSeconds: Int = 0
    var isFinished: Bool = false
    
    func startTimer() {
        withAnimation(.easeInOut(duration: 0.25)) { isStarted = true }
        timerStringValue = "\(hour == 0 ? "" : "\(hour):")\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(second >= 10 ? "\(second)" : "0\(second)")"
        
        // Calculating
        totalSeconds = (hour * 3600) + (minutes * 60) + second
        staticTotalSeconds = totalSeconds
        addNewTimer = false
        addNotification()
    }
    
    func stopTimer() {
        withAnimation {
            isStarted = false
            hour = 0
            minutes = 0
            second = 0
            progress = 1
        }
        totalSeconds = 0
        staticTotalSeconds = 0
        timerStringValue = "00:00"
    }
    
    func updateTimer() {
        totalSeconds -= 1
        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress)
        
        hour = totalSeconds / 3600
        minutes = (totalSeconds / 60) % 60
        second = (totalSeconds % 60)
        timerStringValue = "\(hour == 0 ? "" : "\(hour):")\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(second >= 10 ? "\(second)" : "0\(second)")"
        if hour == 0 && second == 0 && minutes == 0 {
            isStarted = false
            print("Finish")
            isFinished = true
        }
    }
    
    func addNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Time's up"
        content.body = "Your timer has finished"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticTotalSeconds), repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
