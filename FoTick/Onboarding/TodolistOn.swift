//
//  TodolistOn.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 9/8/24.
//

import SwiftUI

struct TodolistOn: View {
    var body: some View {
        NavigationStack {
            HStack {
                Text("Welcome to")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.black)
                    .padding(.top, 20)
                
                Text("FoTick")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.blue)
                    .padding(.top, 20)
            }
            
//            Text("FoTick is a simple and powerful task manager that helps you to organize your tasks and get things done.")
//                .font(.title3)
//                .foregroundStyle(.gray)
//                .padding(.top, 10)
            Text("Task")
                .font(.title)
                .bold()
                .foregroundStyle(.black)
                .padding(.top, 20)
            
            Text("Record your work, free your mind and manage everything gently to enhance productivity.")
                .font(.title3)
                .foregroundStyle(.gray)
                .padding(.top, 10)
        }
    }
}

#Preview {
    TodolistOn()
}
