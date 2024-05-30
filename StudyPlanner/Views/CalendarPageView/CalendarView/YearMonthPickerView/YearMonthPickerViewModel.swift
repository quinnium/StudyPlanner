//
//  YearMonthPickerViewModel.swift
//  StudyPlanner
//
//  Created by Quinn on 14/04/2024.
//

import Foundation
import SwiftUI

@Observable
final class YearMonthPickerViewModel {
    
    var dateWrapper: DateWrapper
    var selectedMonth: Int {
        didSet {
            updateMonthDate()
        }
    }
    var selectedYear: Int {
        didSet {
            updateMonthDate()
        }
    }
    var yearOptions = ClosedRange(1984..<2100)
    private let calendar = Calendar.current
    
    enum MonthOptions: Int, CaseIterable {
        case Jan = 1
        case Feb = 2
        case Mar = 3
        case Apr = 4
        case May = 5
        case Jun = 6
        case Jul = 7
        case Aug = 8
        case Sep = 9
        case Oct = 10
        case Nov = 11
        case Dec = 12
    }
    
    init(dateWrapper: DateWrapper) {
        self.dateWrapper = dateWrapper
        selectedMonth = calendar.component(.month, from: dateWrapper.monthDate)
        selectedYear = calendar.component(.year, from: dateWrapper.monthDate)
    }
    
    func updateMonthDate() {
        var components = DateComponents()
        components.year = selectedYear
        components.month = selectedMonth
        components.day = 01
        dateWrapper.monthDate = calendar.date(from: components) ?? .now
    }
}
