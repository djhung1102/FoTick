//
//  MenuCategory.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 3/8/24.
//

import SwiftUI
import SwiftData

struct MenuCategory: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Bindable var category: Category
    @State var categoryEdit: Category?
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "pencil")
                    .font(.system(size: 20))
                    .foregroundStyle(.blue)
                    .padding(.trailing, 8)
                
                Text("Edit")
                    .foregroundStyle(.blue)
                    .font(.system(size: 19))
                
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .font(.system(size: 20))
                    .foregroundStyle(.black)
                    .padding(.trailing, 8)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .onTapGesture {
                categoryEdit = category
            }
            
            HStack {
                Image(systemName: "trash")
                    .font(.system(size: 20))
                    .foregroundStyle(.red)
                    .padding(.trailing, 8)
                
                Text("Delete")
                    .foregroundStyle(.red)
                    .font(.system(size: 19))
                
                Spacer()
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .onTapGesture {
                modelContext.delete(category)
                dismiss()
            }
            
            Divider()
            
            HStack {
                Spacer()
                
                Text("Cancel")
                    .foregroundStyle(.black)
                    .font(.system(size: 19))
                
                Spacer()
            }
            .padding(.vertical, 12)
            .onTapGesture {
                dismiss()
            }
        }
        .sheet(item: $categoryEdit) {
            categoryEdit = nil
        } content: { item in
            NavigationStack {
                UpdateCategoryView(category: item)
            }
            .presentationDetents([.large])
        }
    }
}

//#Preview {
//    MenuCategory()
//}
