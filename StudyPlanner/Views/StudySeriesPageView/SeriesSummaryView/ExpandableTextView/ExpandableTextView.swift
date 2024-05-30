//
//  ExpandableTextView.swift
//  StudyPlanner
//
//  Created by Quinn on 12/05/2024.
//

import SwiftUI

// Not to be used within a Navigation View (using within a NavigationStack will cause unexpected behaviour with Geomtery Readers' calcs)
struct ExpandableTextView: View {
    let textString: String
    @State var truncated: Bool = false
    @State var isExpanded: Bool = false
    
    var body: some View {
        HStack(spacing:0) {
            VStack(alignment: .trailing) {
                // Real Text displayed (may or may not be expanded)
                Text(textString)
                    .lineLimit(isExpanded ? nil : 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                if isExpanded {
                    Button("Show less") {
                        withAnimation(.default) {
                            isExpanded = false
                        }
                    }
                    .bold()
                }
            }
            if truncated && !isExpanded {
                Button("Show more") {
                    withAnimation(.default) {
                        isExpanded = true
                    }
                }
                .bold()
            }
        }
        // Hidden background to perform calculations to determine if text is truncated
        .background {
            // Render text on one line and measure its size with a geomtery reader
            Text(textString)
                .lineLimit(1)
                .background {
                    GeometryReader { singleLineTextGeo in
                        // Container (with greatest height possible) to render text on as many lines as needed + measure height with geo reader
                        ZStack {
                            Text(textString)
                                .lineLimit(nil)
                                .background {
                                    GeometryReader { multiLineTextGeo in
                                        // DummyView in order to run 'onAppear' to compare heights of texts rendering
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
    }
}

#Preview {
    ExpandableTextView(textString: "This is some long text to show an example of a string that requires truncating")
        .padding()
}
