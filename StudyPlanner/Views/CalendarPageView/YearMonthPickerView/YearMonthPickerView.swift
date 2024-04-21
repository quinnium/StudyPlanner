//
//  YearMonthPickerView.swift
//  StudyPlanner
//
//  Created by Quinn on 14/04/2024.
//

import SwiftUI

struct YearMonthPickerView: View {
    
    @Bindable var vm: YearMonthPickerViewModel
    
    var body: some View {
        VStack(spacing: -1) {
            // Year Picker
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 30) {
                        ForEach(vm.yearOptions, id:\.self) { year in
                            Button(year.description) {
                                vm.selectedYear = year
                            }
                            .foregroundStyle(year == vm.selectedYear ? Color.blue : Color.gray)
                        }
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 50)
                }
                .background(Color.blue.opacity(0.15).gradient)
                .border(Color.blue, width: 1)
                .scrollIndicators(.hidden)
                .onAppear {
                    proxy.scrollTo(vm.selectedYear, anchor: .center)
                }
                .onChange(of: vm.selectedYear) {
                    withAnimation {
                        proxy.scrollTo(vm.selectedYear, anchor: .center)
                    }
                }
            }

            // Month Picker
            ScrollViewReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: 30) {
                        ForEach(YearMonthPickerViewModel.MonthOptions.allCases, id: \.rawValue) { month in
                            Button(String(describing: month)) {
                                vm.selectedMonth = month.rawValue
                            }
                            .foregroundStyle(month.rawValue == vm.selectedMonth ? Color.blue : Color.gray)
                        }
                    }
                    .padding(.vertical, 15)
                    .padding(.horizontal, 50)
                }
                .background(Color.blue.opacity(0.15).gradient)
                .border(Color.blue, width: 1)
                .scrollIndicators(.hidden)
                .onAppear {
                    proxy.scrollTo(vm.selectedMonth, anchor: .center)
                }
                .onChange(of: vm.selectedMonth) {
                    withAnimation {
                        proxy.scrollTo(vm.selectedMonth, anchor: .center)
                    }
                }
            }
        }
    }
}

#Preview {
    return YearMonthPickerView(vm: YearMonthPickerViewModel(dateWrapper: .init(dateSelected: .now, monthDate: .now)))
}
