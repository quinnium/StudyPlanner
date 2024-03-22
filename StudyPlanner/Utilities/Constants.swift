//
//  Constants.swift
//  StudyPlanner
//
//  Created by Quinn on 23/02/2024.
//

import SwiftUI
import SwiftData

enum Constants {

}

struct MockData {
    static let subjects: [String]                   = ["Maths", "Physics", "Algebra", "Chemistry", "Technology", "English"]
    static let colors: [SPColor]                    = SPColor.allCases
    static let dates: [Date]                        = [Date.now, Date.distantFuture, Date.distantPast]
}
