//
//  SessionsListView.swift
//  StudyPlanner
//
//  Created by Quinn on 22/04/2024.
//

import SwiftUI

struct SessionsListView: View {
    
    @Bindable var vm: SessionsListViewModel
    
    var body: some View {
        List(vm.sessions) { session in
            if let parentSeries = session.parentSeries {
                Button {
                    vm.didSelectSeries(parentSeries)
                } label: {
                    HStack(spacing: 10) {
                        Circle()
                            .foregroundStyle(Color.from(spColor: parentSeries.color))
                            .frame(width: 20)
                        Text(parentSeries.subject)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    SessionsListView(vm: .init(fromDate: .now.startOfCalendarMonth, toDate: .now.endOfCalendarMonth, didSelectSeries: {_ in }))
}
