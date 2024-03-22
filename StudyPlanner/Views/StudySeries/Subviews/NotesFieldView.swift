//
//  NotesFieldView.swift
//  StudyPlanner
//
//  Created by Quinn on 02/03/2024.
//

import SwiftUI

struct NotesFieldView: View {
    @Binding var notesText: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Notes")
                Spacer()
            }
            ZStack(alignment: .topLeading) {
                TextEditor(text: $notesText)
                    .frame(height: 100)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary, lineWidth: 1)
                    }
                if notesText.isEmpty {
                    Text("Notes (optional)")
                        .foregroundColor(Color(.systemGray3))
                        .padding(6)
                        .allowsHitTesting(false)
                }
            }
        }
    }
}

#Preview {
    NotesFieldView(notesText: .constant("Testing"))
}
