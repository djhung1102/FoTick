//
//  TestView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 29/7/24.
//

import SwiftUI

// Mẫu dữ liệu
struct Task1: Identifiable {
    var id = UUID()
    var title: String
    var date: String
    var isFlagged: Bool
}

struct TestView: View {
    // Dữ liệu mẫu
    let tasks = [
        Task1(title: "Gym", date: "07/28", isFlagged: false),
        Task1(title: "Chơi", date: "07/28", isFlagged: true)
    ]
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                TaskRow(task: task)
            }
        }
        .frame(width: .infinity)
    }
}

struct TaskRow: View {
    var task: Task1
    
    var body: some View {
        HStack {
            Circle()
                .stroke(lineWidth: 2)
                .frame(width: 24, height: 24)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                HStack {
                    Text(task.date)
                        .font(.subheadline)
                        .foregroundColor(.red)
                    if task.isFlagged {
                        Image(systemName: "flag.fill")
                            .foregroundColor(.red)
                    } else {
                        Image(systemName: "bell")
                            .foregroundColor(.gray)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .padding(.horizontal)
    }
}

#Preview {
    TestView()
}
