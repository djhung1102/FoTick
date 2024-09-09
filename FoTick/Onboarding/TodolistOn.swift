//
//  TodolistOn.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 9/8/24.
//

import SwiftUI

struct TodolistOn: View {
    @Binding var isFirstLaunch: Bool
    
    var body: some View {
        NavigationStack {
            Spacer()
            HStack {
                Text("Welcome to")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.black)
                    .padding(.top, 20)
                
                Text("FoTick")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.blue)
                    .padding(.top, 20)
            }
            
            Image("Anh2")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .padding(.top, 20)
            
            Text("FoTick is a simple and powerful task manager that helps you to organize your tasks and get things done.")
                .font(.title3)
                .foregroundStyle(.gray)
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Button {
                withAnimation {
                    UserDefaults.standard.set(true, forKey: "hasLaunched")
                    isFirstLaunch = false
                }
            } label: {
                HStack(alignment: .center, spacing: 10) {
                    Text("Get Started")
                        .font(.title3)
                        .bold()
                        
                    Image(systemName: "arrow.right")
                        .font(.title3)
                        .foregroundStyle(.white)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 85)
                .padding(.vertical, 14)
                .background(.blue)
                .cornerRadius(10)
            }

        }
    }
}

#Preview {
    TodolistOn(isFirstLaunch: .constant(true))
}
