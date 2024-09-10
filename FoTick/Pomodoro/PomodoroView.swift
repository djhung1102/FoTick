//
//  PomodoroView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 10/9/24.
//

import SwiftUI

struct PomodoroView: View {
    @State var pomodoroManager = PomodoroManager()
    
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack {
            Text("Pomodoro Timer")
                .font(.title2.bold())
                .foregroundStyle(.black)
            
            GeometryReader { proxy in
                VStack(spacing: 15) {
                    // Time Ring
                    ZStack {
                        Circle()
                            .fill(.black.opacity(0.03))
                            .padding(-40)
                        
                        Circle()
                            .trim(from: 0, to: pomodoroManager.progress)
                            .stroke(Color(.blue).opacity(0.03), lineWidth: 80)
                        // Shadow
                        Circle()
                            .stroke(Color(.blue), lineWidth: 5)
                            .blur(radius: 15)
                            .padding(-2)
                        
                        Circle()
                            .fill(Color(.white))
                        
                        Circle()
                            .trim(from: 0, to: pomodoroManager.progress)
                            .stroke(Color(.blue).opacity(0.7), lineWidth: 10)
                        
                        // Knob
                        GeometryReader { proxy in
                            let size = proxy.size
                            
                            Circle()
                                .fill(Color(.blue))
                                .frame(width: 30, height: 30)
                                .overlay {
                                    Circle().fill(.white)
                                        .padding(5)
                                }
                                .frame(width: size.width, height: size.height, alignment: .center)
                                .offset(x: size.height / 2)
                                .rotationEffect(.init(degrees: pomodoroManager.progress * 360))
                        }
                        
                        Text(pomodoroManager.timerStringValue)
                            .font(.system(size: 45, weight: .regular))
                            .rotationEffect(.init(degrees: 90))
                            .animation(.none, value: pomodoroManager.progress)
                    }
                    .padding(60)
                    .frame(height: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeInOut, value: pomodoroManager.progress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                    Button {
                        if pomodoroManager.isStarted {
                            pomodoroManager.stopTimer()
                        } else {
                            showSheet.toggle()
                            pomodoroManager.addNewTimer = true
                        }
                    } label: {
                        Image(systemName: !pomodoroManager.isStarted ? "timer" : "pause")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white)
                            .frame(width: 80, height: 80)
                            .background {
                                Circle().fill(.blue)
                            }
                            .shadow(color: .blue, radius: 8, x: 0, y: 0)
                    }

                }
//                .onTapGesture {
//                    fotickManager.progress = 0.5
//                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .padding()
        .background {
            Color(.white)
                .ignoresSafeArea()
        }
        .overlay {
            ZStack {
                Color.black.opacity(pomodoroManager.addNewTimer ? 0.25 : 0)
                    .onTapGesture {
                        pomodoroManager.hour = 0
                        pomodoroManager.minutes = 0
                        pomodoroManager.second = 0
                        pomodoroManager.addNewTimer = false
                    }
                
                NewTimerView()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: pomodoroManager.addNewTimer ? 0: 400)
            }
            .animation(.easeInOut, value: pomodoroManager.addNewTimer)
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if pomodoroManager.isStarted {
                pomodoroManager.updateTimer()
            }
        }
        .alert("Time's up", isPresented: $pomodoroManager.isFinished) {
            Button("Start New", role: .cancel) {
                pomodoroManager.stopTimer()
                pomodoroManager.addNewTimer = true
            }
            
            Button("Close", role: .destructive) {
                pomodoroManager.stopTimer()
            }
        }
    }
    
    // New Timer Bottom sheet
    @ViewBuilder
    func NewTimerView() -> some View {
        VStack(spacing: 15) {
            Text("Add New Timer")
                .font(.title2.bold())
                .foregroundStyle(.black)
                .padding(.top, 10)
            
            HStack(spacing: 15) {
                Text("\(pomodoroManager.hour) hr")
                    .font(.title3)
                    .fontWeight (.semibold)
                    .foregroundColor (.blue)
                    .padding(.horizontal, 20)
                    .padding (.vertical, 12)
                    .background {
                        Capsule()
                            .fill(.blue.opacity (0.07))
                    }
                    .contextMenu {
                        ContextMenuOptions(maxValue: 12, hint: "hr") { value in
                            pomodoroManager.hour = value
                        }
                    }
                
                Text("\(pomodoroManager.minutes) min")
                    .font(.title3)
                    .fontWeight (.semibold)
                    .foregroundColor (.blue)
                    .padding(.horizontal, 20)
                    .padding (.vertical, 12)
                    .background {
                        Capsule()
                            .fill(.blue.opacity (0.07))
                    }
                    .contextMenu {
                        ContextMenuOptions(maxValue: 60, hint: "min") { value in
                            pomodoroManager.minutes = value
                        }
                    }
                
                Text("\(pomodoroManager.second) sec")
                    .font(.title3)
                    .fontWeight (.semibold)
                    .foregroundColor (.blue)
                    .padding(.horizontal, 20)
                    .padding (.vertical, 12)
                    .background {
                        Capsule()
                            .fill(.blue.opacity (0.07))
                    }
                    .contextMenu {
                        ContextMenuOptions(maxValue: 60, hint: "sec") { value in
                            pomodoroManager.second = value
                        }
                    }
            }
            .padding(.top, 20)
            
            Button {
                pomodoroManager.startTimer()
            } label: {
                Text("Save")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .background {
                        Capsule()
                            .fill(.blue.opacity(0.1))
                    }
            }
            .disabled(pomodoroManager.second == 0)
            .opacity(pomodoroManager.second == 0 ? 0.5 : 1)
            .padding(.top)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10), style: .continuous)
                .fill(Color.white)
                .ignoresSafeArea()
        }
    }
    
    // Context Menu Option
    @ViewBuilder
    func ContextMenuOptions(maxValue: Int, hint: String, onClick: @escaping (Int)->()) -> some View {
        ForEach(0...maxValue, id: \.self) { value in
            Button("\(value) \(hint)") {
                onClick(value)
            }
        }
    }
}

#Preview {
    PomodoroView()
        .environment(PomodoroManager())
}
