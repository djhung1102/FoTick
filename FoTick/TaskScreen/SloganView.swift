//
//  SloganView.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 28/7/24.
//

import SwiftUI

struct SloganView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                VStack {
                    Text("Execellent, Today's your plan is almost done")
                        .bold()
                        .font(.headline)
                }
                
                Spacer()
                
                VStack {
                    Text("You have 2 tasks left")
                        .bold()
                }
            }
            .padding()
            .background(.blue.opacity(0.6))
            .clipShape(.rect(cornerRadius: 16))
        }
    }
}

#Preview {
    SloganView()
}
