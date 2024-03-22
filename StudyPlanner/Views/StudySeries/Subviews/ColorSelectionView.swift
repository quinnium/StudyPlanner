//
//  ColorSelectionView.swift
//  StudyPlanner
//
//  Created by Quinn on 02/03/2024.
//

import SwiftUI

struct ColorSelectionView: View {
    var allSPColors: [SPColor]
    @Binding var selectedColor: SPColor?
    
    var body: some View {
        VStack {
            HStack {
                Text("Colour code")
                Spacer()
            }
            HStack(spacing: 5) {
                ForEach(allSPColors, id:\.self) { spColor in
                    Button {
                        selectedColor = spColor
                    } label: {
                        ZStack{
                            Circle()
                                .stroke(selectedColor == spColor ? Color.from(spColor: spColor) : .clear, lineWidth: 3)
                                .frame(height: 35)
                            Circle()
                                .foregroundStyle(Color.from(spColor: spColor))
                                .frame(height: 25)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ColorSelectionView(allSPColors: SPColor.allCases, selectedColor: .constant(SPColor.pink))
}
