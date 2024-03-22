//
//  Color+Ext.swift
//  StudyPlanner
//
//  Created by Quinn on 25/02/2024.
//

import SwiftUI

extension Color {
    static func from(spColor: SPColor?) -> Color {
        switch spColor {
            case .pink:
                return .pink
            case .orange:
                return .orange
            case .yellow:
                return .yellow
            case .green:
                return .green
            case .blue:
                return .blue
            case .purple:
                return .purple
            case .brown:
                return .brown
            case .mint:
                return .mint
            case .indigo:
                return .indigo
            default:
                return .secondary
        }
    }
    
    func convertToSPColor() -> SPColor? {
        switch self {
            case .pink:
                return SPColor.pink
            case .orange:
                return SPColor.orange
            case .yellow:
                return SPColor.yellow
            case .green:
                return SPColor.green
            case .blue:
                return SPColor.blue
            case .purple:
                return SPColor.purple
            case .brown:
                return SPColor.brown
            case .mint:
                return SPColor.mint
            case .indigo:
                return SPColor.indigo
            default:
                return nil
        }
    }
}
