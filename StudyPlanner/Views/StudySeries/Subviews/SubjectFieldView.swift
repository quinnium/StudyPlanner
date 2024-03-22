//
//  SubjectFieldView.swift
//  StudyPlanner
//
//  Created by Quinn on 02/03/2024.
//

import SwiftUI

struct SubjectFieldView: View {
    @Binding var subject: String
    @FocusState var subjectInFocus
    
    var body: some View {
        HStack(spacing: 20) {
            Text("Subject")
            ZStack(alignment: .trailing) {
                TextField("Study subject", text: $subject)
                    .focused($subjectInFocus)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .padding(.trailing, 30)
                if subject.isNotEmpty && subjectInFocus {
                    Button {
                        subject = ""
                    } label: {
                        Image(systemName: "delete.left")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                    .padding(.trailing, 8)
                }
            }
        }
    }
}

#Preview {
    SubjectFieldView(subject: .constant("Test"), subjectInFocus: FocusState())
}
