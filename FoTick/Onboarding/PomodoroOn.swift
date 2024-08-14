//
//  PomodoroOn.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 9/8/24.
//

import SwiftUI

struct PomodoroOn: View {
    var body: some View {
        NavigationStack {
            Text("Pomodoro")
                .font(.title)
                .bold()
                .foregroundStyle(.black)
                .padding(.top, 20)
            
            Text("Focus creates excellence. Use the Pomodoro method to help you get work done efficiently.")
                .font(.title3)
                .foregroundStyle(.gray)
                .padding(.top, 10)
        }
            
    }
}

#Preview {
    PomodoroOn()
}
