//
//  ExpandableTextView.swift
//  StudyPlanner
//
//  Created by Quinn on 12/05/2024.
//

import SwiftUI

struct ExpandableTextView: View {
    let textString: String
    let minLines: Int
    @State var truncated: Bool = false
    @State var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .trailing) {
            // Real Text displayed (may or may not be expanded)
            Text(textString)
                .lineLimit(isExpanded ? nil : minLines)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    // Render text on one line to measure its size
                    Text(textString)
                        .lineLimit(minLines)
                        .background {
                            GeometryReader { singleLineTextGeo in
                                // Create a container (with greatest height possible) to render text in (with as many lines as it needs)
                                ZStack {
                                    Text(textString)
                                        .lineLimit(nil)
                                        .background {
                                            GeometryReader { multiLineTextGeo in
                                                // DummyView in order to run 'onAppear' to compare widths of texts rendering
                                                Color.clear
                                                    .onAppear {
                                                        truncated = multiLineTextGeo.size.height > singleLineTextGeo.size.height
                                                    }
                                            }
                                        }
                                }
                                .frame(height: .greatestFiniteMagnitude)
                            }
                        }
                        .hidden()
                }
            if truncated {
                Button {
                    withAnimation(.default) {
                        isExpanded.toggle()
                    }
                } label: {
                    Text(isExpanded ? "Show less" : "Show more")
                }
            }
        }
    }
}

#Preview {
    ExpandableTextView(textString: "This is some long text to show an example of something that might need to be expanded to show more text", minLines: 2)
        .padding()
}
