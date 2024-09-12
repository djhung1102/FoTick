//
//  SettingsView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 5/8/24.
//

import SwiftUI
import MessageUI
import StoreKit

struct SettingsView: View {
    @Environment(FoTickManager.self) var fotickManager
    
    @State private var isShowingMailView = false
    @State private var showMailErrorAlert = false
    
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
                    .onTapGesture {
                        openWeb(url: "https://www.fotick.site")
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
                    .onTapGesture {
                        if MFMailComposeViewController.canSendMail() {
                            isShowingMailView = true
                        } else {
                            showMailErrorAlert = true
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
                    .onTapGesture {
                        requestReview()
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
                    .onTapGesture {
                        openWeb(url: "https://fotick.site/privacy-policy")
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
                    .onTapGesture {
                        openWeb(url: "https://fotick.site/terms-of-use")
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
        .sheet(isPresented: $isShowingMailView) {
            MailView(isShowing: $isShowingMailView, result: .constant(nil))
        }
        .alert(isPresented: $showMailErrorAlert) {
            Alert(title: Text("Mail Services Not Available"),
                  message: Text("Please configure a mail account in order to send email."),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    func openWeb(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }
    
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

#Preview {
    SettingsView()
}

struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(isShowing: Binding<Bool>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                isShowing = false
            }
            if let error = error {
                self.result = .failure(error)
            } else {
                self.result = .success(result)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing, result: $result)
    }

    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(["manhhunghd2000@gmail.com"])  // Thay thế bằng email nhà phát triển
        vc.setSubject("Help/Feedback")
        vc.setMessageBody("Please write your feedback or issues here...", isHTML: false)

        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
}
