//
//  CalendarView.swift
//  StudyPlanner
//
//  Created by Quinn on 26/05/2024.
//

import SwiftUI

struct CalendarView: View {
    
    @Bindable var vm: CalendarViewModel
    @State var tabViewHeight: CGFloat? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Buttons
            HStack(spacing: 20) {
                Button("Today") {
                    vm.dateWrapper.selectToday()
                }
                Spacer()
                Button("", systemImage: "chevron.left") {
                    withAnimation {
                        vm.tabViewSelection = 0
                    }
                }
                Button(vm.monthAndYearText) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        vm.isShowingYearMonthPicker.toggle() }
                }
                Button("", systemImage: "chevron.right") {
                    withAnimation {
                        vm.tabViewSelection = 2
                    }
                }
            }
            .padding(10)
            
            // Year & Month picker
            YearMonthPickerView(vm: vm.yearMonthPickerViewModel)
                .frame(height: vm.isShowingYearMonthPicker ? 100 : 0)
                .zIndex(-1)
                .clipped()
            
            // Tab View for Calendar
            TabView(selection: $vm.tabViewSelection) {
                CalendarMonthView(vm: vm.previousCalendarMonthViewModel)
                    .tag(0)
                CalendarMonthView(vm: vm.currentCalendarMonthViewModel)
                    .background {
                        // Preference Key used to communicate this view's height up the hierarchy
                        GeometryReader { geo in
                            Color.clear
                                .preference(key: SPViewHeightPreferenceKey.self, value: [geo.size.height])
                        }
                    }
                    .tag(1)
                    .onDisappear {
                        vm.reOrderAfterMonthChange()
                    }
                    
                CalendarMonthView(vm: vm.nextCalendarMonthViewModel)
                    .tag(2)
            }
            .frame(height: tabViewHeight)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onPreferenceChange(SPViewHeightPreferenceKey.self) { heights in
                // Adjust height of TabView to 'hug' its content, following feedback of heights of subview(s)
                withAnimation {
                    self.tabViewHeight = heights.max()
                }
                
            }
        }
        .padding(.top, 10)
        .background {
            Color.init(uiColor: .systemBackground)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 2)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    VStack {
        CalendarView(vm: CalendarViewModel(dateWrapper: .init(dateSelected: .now), allSessions: []))
    }
    
}
