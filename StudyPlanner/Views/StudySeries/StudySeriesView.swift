//
//  StudySeriesView.swift
//  StudyPlanner
//
//  Created by Quinn on 23/02/2024.
//

import SwiftUI
import SwiftData
import Observation

struct StudySeriesView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var vm: StudySeriesViewModel
    
    init(vm: StudySeriesViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                Spacer()
                Button("Save") {
                    vm.saveStudySeries()
                    dismiss()
                }
                .disabled(!vm.isValidToSave)
                .bold()
            }
            SubjectFieldView(subject: $vm.subjectText)
            ColorSelectionView(allSPColors: vm.allSPColors, selectedColor: $vm.selectedColour)
            NotesFieldView(notesText: $vm.notesText)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                    ForEach($vm.studySessions, id: \.id) { session in
                        let index = vm.studySessions.firstIndex(of: session.wrappedValue) ?? 0
                        StudySessionView(session: session, isNewSeries: vm.isNewStudySeries, index: index,  color: Color.spColor(vm.selectedColour)) {
                            vm.removeSession(atIndex: index)
                        }
                        .frame(minHeight: 120)
                    }
                    
                    Button {
                        withAnimation {
                            vm.addSession()
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.spColor(vm.selectedColour), lineWidth: 3)
                                .opacity(0.2)
                            VStack {
                                Label("Add", systemImage: "plus.circle.fill")
                                    .foregroundStyle(Color.spColor(vm.selectedColour))
                                    .brightness(-0.3)
                            }
                        }
                        .frame(minHeight: 120)
                    }
                }
            }
        }
        .padding()
        .onChange(of: vm.studySessions.map { $0.date}) {
            if vm.sessionsOutOfDateOrder {
                withAnimation {
                    vm.reOrderStudySessions()
                }
            }
        }
    }
}


#Preview {
    return NavigationStack {
        StudySeriesView(vm: StudySeriesViewModel(studySeries: nil, forTesting: true))
    }
}
