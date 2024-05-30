//
//  DaySessionsListView.swift
//  StudyPlanner
//
//  Created by Quinn on 22/04/2024.
//

import SwiftUI
import SwiftData

struct DaySessionsListView: View {
    
    @Bindable var vm: DaySessionsListViewModel
    var onSheetDismiss: () -> Void
    
    var body: some View {
        if vm.sessions.isNotEmpty {
            ScrollView {
                GeometryReader { geo in
                    Spacer()
                        .onChange(of: geo.frame(in: .scrollView)) { oldValue, newValue in
                            vm.headerOpacity = Double(max(min(newValue.maxY / 30, 1),0))
                        }
                }
                .frame(height: 30)
                VStack {
                    ForEach(vm.sessions, id: \.id) { session in
                        SessionSummaryView(vm: SessionSummaryViewModel(session: session))
                            .animation(.easeIn(duration: 0.2), value: vm.sessions.map {$0.isCompleted})
                            .frame(minHeight: 30)
                            .onTapGesture {
                                vm.selectedSeriesForEditing = session.parentSeries
                            }
                    }
                }
            }
            .padding(.horizontal, 5)
            .sheet(item: $vm.selectedSeriesForEditing) {
                onSheetDismiss()
            } content: { series in
                StudySeriesView(vm: vm.studySeriesViewModel)
            }
            .background(alignment: .top) {
                HStack {
                    Group {
                        Text("Subject")
                        Spacer()
                        Text("Complete")
                    }
                    .foregroundStyle(Color.gray)
                    .font(.footnote)
                    .bold()
                }
                .padding(.top, 10)
                .padding(.horizontal, 8)
                .opacity(vm.headerOpacity)
            }
        }
        else {
            Text("No sessions for date selected")
                .italic()
                .foregroundStyle(Color.gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
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
    let allSessions = modelDataSource.fetchAllObjects(objectType: StudySession.self)
    
    return DaySessionsListView(vm: DaySessionsListViewModel(sessions: allSessions), onSheetDismiss: {})
}
