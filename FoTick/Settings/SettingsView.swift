//
//  SettingsView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 5/8/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(FoTickManager.self) var fotickManager
    
    var body: some View {
        NavigationStack {
            List {
                HStack(alignment: .center) {
                    VStack(alignment: .center) {
                        Text("\(fotickManager.doneTasks.count)")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.black)
                        
                        Text("Completed")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                    
                    Divider()
                        .frame(height: 50) // Chiều cao của gạch
                        .rotationEffect(.degrees(180))
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Text("\(fotickManager.notDoneTasks.count)")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.black)
                        
                        Text("Incomplete")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                    }
                }
                .padding(.horizontal, 16)
                .onAppear {
                    fotickManager.fetchTasks(for: Date())
                    fotickManager.fetchTasksNotDone(for: Date())
                }
                
                //                Section {
                //                    VStack {
                //                        HStack {
                //                            VStack(alignment: .leading) {
                //                                HStack {
                //                                    Text("Statistics")
                //                                        .font(.title2)
                //                                        .bold()
                //                                        .foregroundStyle(.black)
                //
                //                                    Image(systemName: "chart.line.uptrend.xyaxis")
                //                                        .resizable()
                //                                        .scaledToFit()
                //                                        .frame(width: 20, height: 20)
                //                                        .foregroundColor(.blue)
                //                                }
                //                                Text("View your statistics")
                //                                    .font(.caption)
                //                                    .foregroundColor(.secondary)
                //                            }
                //
                //                            Spacer()
                //
                //                            Image(systemName: "chevron.forward")
                //                                .resizable()
                //                                .scaledToFit()
                //                                .frame(width: 18, height: 18)
                //                                .foregroundColor(.gray)
                //                        }
                //                    }
                //                    .padding(.vertical, 10)
                //                }
                
                Section("Notification") {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "bell")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.blue)
                                    
                                    Text("Notification")
                                        .font(.title3)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                    }
                    .onTapGesture {
                        fotickManager.openSettingsNotificationInIOS()
                    }
                }
                
                Section("App") {
                    VStack {
                        HStack(alignment: .center, spacing: 16) {
                            Image(systemName: "info.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) {
                                Text("About")
                                    .font(.title3)
                                    .foregroundStyle(.black)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    VStack {
                        HStack(alignment: .center, spacing: 16) {
                            Image(systemName: "envelope")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) {
                                Text("Get help or feedback")
                                    .font(.title3)
                                    .foregroundStyle(.black)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    VStack {
                        HStack(alignment: .center, spacing: 16) {
                            Image(systemName: "star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) {
                                Text("Rate us on App Store")
                                    .font(.title3)
                                    .foregroundStyle(.black)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    VStack {
                        HStack {
                            Image(systemName: "lock")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) {
                                Text("Privacy Policy")
                                    .font(.title3)
                                    .foregroundStyle(.black)
                            }
                            
                            Spacer()
                        }
                    }
                    VStack {
                        HStack {
                            Image(systemName: "doc.text")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) {
                                Text("Term of Service")
                                    .font(.title3)
                                    .foregroundStyle(.black)
                            }
                            
                            Spacer()
                        }
                    }
                }
                
                Section {
                    VStack {
                        HStack {
                            Image(systemName: "square.3.layers.3d")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) {
                                Text("Version")
                                    .font(.title3)
                                    .foregroundStyle(.black)
                            }
                            
                            Spacer()
                            
                            Text("1.0.0")
                                .font(.headline)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
