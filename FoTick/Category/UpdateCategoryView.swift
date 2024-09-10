//
//  UpdateCategoryView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 3/8/24.
//

import SwiftUI

struct UpdateCategoryView: View {
    
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
    
    @Bindable var category: Category
    
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
        .navigationTitle("Update Category")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    category.name = name
                    category.icon = selectedIcon
                    category.color = selectedColor
                    name = ""
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }
        .onAppear {
            name = category.name
            selectedIcon = category.icon
            selectedColor = category.color
        }
    }
}

//#Preview {
//    UpdateCategoryView()
//}
