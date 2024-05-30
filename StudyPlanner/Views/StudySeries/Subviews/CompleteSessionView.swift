//
//  CompleteSessionView.swift
//  StudyPlanner
//
//  Created by Quinn on 27/04/2024.
//

import SwiftUI

struct CompleteSessionView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isComplete: Bool
    let text: String
    let size: CGFloat
    let color: Color
    
    var body: some View {
        Button {
            isComplete.toggle()
        } label: {
            HStack {
                Text(text)
                    .font(.system(size: size))
                    .foregroundStyle(colorScheme == .dark ?
                                        color.spStyleSecondarytTextDark :
                                        color.spStyleSecondaryText)
                if isComplete {
                    Image(systemName: "checkmark.square")
                        .foregroundStyle(colorScheme == .dark ?
                                         color.spStyleSecondarytTextDark :
                                         color.spStyleSecondaryText)
                        .symbolRenderingMode(.monochrome)
                } else {
                    Image(systemName: "square")
                        .foregroundStyle(colorScheme == .dark ?
                                         color.spStyleSecondarytTextDark :
                                         color.spStyleSecondaryText)
                    
                }
            }
            .font(.system(size: size))
            
        }
        .sensoryFeedback(trigger: isComplete) { _, newValue in
            newValue == true ? .success : .warning
        }
    }
}

#Preview {
    
    struct Preview: View {
        @State var isComplete = true
        var body: some View {
            CompleteSessionView(isComplete: $isComplete, text: "Test", size: 30, color: .red)
        }
    }
    return Preview()
}
