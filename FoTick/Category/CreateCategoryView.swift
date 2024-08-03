//
//  CreateCategoryView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 30/7/24.
//

import SwiftUI

struct CreateCategoryView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name: String = ""
    @State private var selectedIcon: String = "folder"
    @State private var selectedColor: String = "blue"
    
    let colors: [(name: String, color: Color)] = [
        ("blue", .blue),
        ("red", .red),
        ("orange", .orange),
        ("yellow", .yellow),
        ("green", .green),
        ("purple", .purple)
    ]
    let icons: [String] = [
        "folder", "briefcase", "film", "clock", "pencil",
        "heart", "house", "fork.knife", "cart", "tag", "gift", "star"
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        List {
            Section("Category Title") {
                TextField("Enter Category Title", text: $name)
            }
            
            Section("Color") {
                HStack(alignment: .center) {
                    ForEach(colors, id: \.name) { color in
                        Spacer()
                        Circle()
                            .fill(color.color)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()
                                    .stroke(selectedColor == color.name ? Color.gray : Color.clear, lineWidth: 3)
                            )
                            .onTapGesture {
                                selectedColor = color.name
                            }
                            .padding(.vertical, 5)
                        
                        Spacer()
                    }
                }
            }
            
            Section("Icon") {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(icons, id: \.self) { icon in
                        Image(systemName: icon)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(selectedIcon == icon ? Color(selectedColor) : Color(.gray))
                            .onTapGesture {
                                selectedIcon = icon
                            }
                            .padding()
                    }
                }
            }
        }
        .navigationTitle("Add Category")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    let category = Category(id: UUID(), name: name, icon: selectedIcon, color: selectedColor)
                    modelContext.insert(category)
                    category.tasks = []
                    name = ""
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                }
                .disabled(name.isEmpty)
            }
        }
    }
}

extension Color {
    init(_ name: String) {
        switch name {
        case "red":
            self = .red
        case "orange":
            self = .orange
        case "yellow":
            self = .yellow
        case "green":
            self = .green
        case "purple":
            self = .purple
        default:
            self = .blue
        }
    }
}

//#Preview {
//    NavigationStack {
//        CreateCategoryView()
//    }
//}
