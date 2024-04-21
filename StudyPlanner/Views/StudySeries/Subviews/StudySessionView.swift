//
//  StudySessionView.swift
//  StudyPlanner
//
//  Created by Quinn on 24/02/2024.
//

import SwiftUI
//import SwiftData


struct StudySessionView: View {
        
    @Binding var session: StudySession
    
    let index: Int
    let color: Color
    var onDelete: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle((color).opacity(0.2))
            VStack(spacing:10) {
                HStack{
                    Text("Session \(index + 1)")
                        .font(.headline)
                        .foregroundStyle(color)
                        .brightness(-0.3)
                    Spacer()
                    if index > 0 {
                        Button("", systemImage: "xmark") {
                            withAnimation {
                                onDelete()
                            }
                        }
                        .foregroundStyle(color)
                        .brightness(-0.3)
                    }
                }
                DatePicker("Session Date", selection: $session.date, in: Constants.Dates.allowableDateRange, displayedComponents: [.date])
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .tint(color)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
            }
            .padding(10)
        }
    }
}

#Preview {
    @State var session1 = StudySession(date: Date())
    return StudySessionView(session: $session1, index: 1, color: .pink, onDelete: {})
    .frame(width: 150)
}
