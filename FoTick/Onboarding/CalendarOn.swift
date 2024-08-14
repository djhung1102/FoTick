//
//  CalendarOn.swift
//  FoTick
//
//  Created by Nguyễn Mạnh Hùng on 9/8/24.
//

import SwiftUI

struct CalendarOn: View {
    @State private var isExpanded = false
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        VStack {
            if isExpanded {
                fullCalendarView()
                    .transition(.move(edge: .top))
            } else {
//                compactCalendarView()
//                    .transition(.move(edge: .top))
            }
        }
        .animation(.spring(), value: isExpanded)
        .gesture(
            DragGesture()
                .updating($dragOffset) { value, state, _ in
                    state = value.translation
                }
                .onEnded { value in
                    if value.translation.height > 50 {
                        isExpanded = true
                    } else if value.translation.height < -50 {
                        isExpanded = false
                    }
                }
        )
    }
    
    @ViewBuilder func compactCalendarView() -> some View {
        HStack {
            ForEach(0..<7) { day in
                VStack {
                    Text(weekdayName(for: day))
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(day + 3)")
                        .font(.headline)
                        .foregroundColor(day == 6 ? .white : .black)
                        .frame(width: 30, height: 30)
                        .background(day == 6 ? Color.blue : Color.clear)
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
    
    @ViewBuilder func fullCalendarView() -> some View {
        VStack(spacing: 10) {
            HStack {
                ForEach(0..<7) { day in
                    Text(weekdayName(for: day))
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            ForEach(0..<5) { row in
                HStack {
                    ForEach(0..<7) { col in
                        Text("\(row * 7 + col + 28)")
                            .font(.headline)
                            .foregroundColor((row * 7 + col + 28) == 9 ? .white : .black)
                            .frame(width: 30, height: 30)
                            .background((row * 7 + col + 28) == 9 ? Color.blue : Color.clear)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
    
    func weekdayName(for day: Int) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "vi_VN")
        return formatter.shortWeekdaySymbols[day]
    }
}

#Preview {
    CalendarOn()
}
