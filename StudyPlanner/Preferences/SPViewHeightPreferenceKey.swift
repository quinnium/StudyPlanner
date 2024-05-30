//
//  SPViewHeightPreferenceKey.swift
//  StudyPlanner
//
//  Created by Quinn on 30/05/2024.
//

import SwiftUI

// Preference Key to communicate a single subview height back up through the view hierarchy
struct SPViewHeightPreferenceKey: PreferenceKey {
    static var defaultValue: [CGFloat] = []
    
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        return value.append(contentsOf: nextValue())
    }
}
