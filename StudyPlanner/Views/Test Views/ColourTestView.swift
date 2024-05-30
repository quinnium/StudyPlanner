//
//  ColourTestView.swift
//  StudyPlanner
//
//  Created by Quinn on 20/05/2024.
//

import SwiftUI

struct ColourTestView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var sessions: [StudySession]
    // Light 70 , Dark 50 (30)
    @State var background: CGFloat = 30
    // Light 50, Dark 60 (75)
    @State var mainText: CGFloat = 75
    // Light 30, Dark 40 (65)
    @State var secondaryText: CGFloat = 65
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text("Background:  " + background.description)
            Slider(value: $background, in: 0...100, step: 1)
            Text("MainText:  " + mainText.description)
            Slider(value: $mainText, in: 0...100, step: 1)
            Text("SecondaryText:  " + secondaryText.description)
            Slider(value: $secondaryText, in: 0...100, step: 1)
        } 
        .padding()
        ScrollView {
            ForEach($sessions, id: \.self) { session in
                
                if let series = session.wrappedValue.parentSeries  {
                    let color = Color.spColor(series.color)
                    let spStyleBackground           = Color(UIColor(color).lightenByPercentage(by: Int(background)))
                    let spStyleMainText             = Color(UIColor(color).darkenByPercentage(by: Int(mainText)))
                    let spStyleSecondaryText        = Color(UIColor(color).darkenByPercentage(by: Int(secondaryText)))
                    let spStyleBackgroundDark       = Color(UIColor(color).darkenByPercentage(by: Int(background)))
                    let spStyleMainTextDark         = Color(UIColor(color).lightenByPercentage(by: Int(mainText)))
                    let spStyleSecondarytTextDark   = Color(UIColor(color).lightenByPercentage(by: Int(secondaryText)))
                    
                    
                    
                    HStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Text(series.subject)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.6)
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(colorScheme == .dark ?
                                                        spStyleMainTextDark :
                                                        spStyleMainText)
                                Spacer()
                            }
                            .font(.system(size: 16))
                            
                            if series.notes.isNotEmpty {
                                ExpandableTextView(textString: series.notes)
                                    .font(.footnote)
                                    .foregroundStyle(colorScheme == .dark ?
                                                        spStyleSecondarytTextDark :
                                                        spStyleSecondaryText)
                            }
                            Text("Sesson 2 of 6")
                                .font(.footnote)
                                .foregroundStyle(colorScheme == .dark ?
                                                    spStyleMainTextDark :
                                                    spStyleMainText)
                        }
                        CompleteSessionView(isComplete: session.isCompleted, text: "", size: 25, color: .primary)
                    }
                    .padding(8)
                    .background() {
                        ZStack {
                            if session.wrappedValue.isCompleted {
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(color, lineWidth: 3)
                                    .contentShape(Rectangle())
                            } else {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(colorScheme == .dark ?
                                                        spStyleBackgroundDark :
                                                        spStyleBackground)
                            }
                        }
                    }
                    .opacity(session.wrappedValue.isCompleted ? 0.6 : 1)
                }
            }
        }
    }
    
}
 
#Preview {
    let modelDataSource = ModelDataSource.forTesting
    for color in SPColor.allCases {
        let session = StudySession(date: Date())
        modelDataSource.insertObject(session)
        var studySeries = StudySeries(subject: "Mathematics", color: color, notes: "This is some very long notes text, used to display a way of detecting truncation. Smooth animation should also be used here", sessions: [])
        modelDataSource.insertObject(studySeries)
        studySeries.sessions = [session]
    }
    let allSessions = modelDataSource.fetchAllObjects(objectType: StudySession.self).sorted { $0.date < $1.date }
    return ColourTestView(sessions: allSessions)
}
