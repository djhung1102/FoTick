//
//  CategoryView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 2/8/24.
//

import SwiftUI
import SwiftData

struct CategoryView: View {
    
    @Query var categories: [Category] = []
    
    @State var showCreateCategory: Bool = false
    @State var categoryEdit: Category?
    
    var body: some View {
        ScrollView {
            ForEach(categories, id: \.id) { category in
                HStack(alignment: .center) {
                    Image(systemName: category.icon)
                        .font(.system(size: 20))
                        .foregroundStyle(Color(category.color))
                        .padding(.trailing, 8)
                    
                    Text(category.name)
                        .foregroundStyle(.black)
                        .font(.system(size: 19))
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .onTapGesture {
                            categoryEdit = category
                        }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            
            HStack(alignment: .center) {
                Image(systemName: "folder.badge.plus")
                    .font(.system(size: 20))
                    .foregroundStyle(.gray)
                    .padding(.trailing, 8)
                
                Text("Add New Category")
                    .foregroundStyle(.gray)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .onTapGesture {
                showCreateCategory.toggle()
            }
        }
        .navigationTitle("Category")
        .sheet(isPresented: $showCreateCategory) {
            NavigationStack {
                CreateCategoryView()
            }
            .presentationDetents([.large])
        }
        .sheet(item: $categoryEdit) {
            categoryEdit = nil
        } content: { item in
            NavigationStack {
                MenuCategory(category: item)
            }
            .presentationDetents([.height(200)])
        }
    }
    
}

#Preview {
    CategoryView()
}
