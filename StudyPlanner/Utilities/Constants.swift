//
//  Constants.swift
//  StudyPlanner
//
//  Created by Quinn on 23/02/2024.
//

import SwiftUI
import SwiftData

enum Constants {
    enum Dates {
        private static var firstPossibleDate: Date {
          var components = DateComponents()
            components.year = 1984
            components.month = 1
            components.day = 1
            components.timeZone = .current
            return Calendar.current.date(from: components) ?? Date.distantPast
        }
        private static var lastPossibleDate: Date {
          var components = DateComponents()
            components.year = 2099
            components.month = 12
            components.day = 31
            components.timeZone = .current
            return Calendar.current.date(from: components) ?? Date.distantFuture
        }
        static var allowableDateRange = firstPossibleDate...lastPossibleDate
    }
    

}

struct MockData {
    static let subjects: [String]                   = ["Maths", "Physics", "Algebra", "Chemistry", "Technology", "English"]
    static let colors: [SPColor]                    = SPColor.allCases
    static let dates: [Date]                        = [Date.now, Date.distantFuture, Date.distantPast]
}
