//
//  TabViewTest.swift
//  StudyPlanner
//
//  Created by Quinn on 26/05/2024.
//

import SwiftUI

struct TabViewTest: View {
    @State var vm = TabViewTestViewModel()
    var body: some View {
        TabView(selection: $vm.selectedIndex) {
            Text(vm.previousNumber.description).tag(0)
//                .frame(width: 400, height: 400)
                .background(Color.red)
                
            Text(vm.currentNumber.description).tag(1)
//                .frame(width: 400, height: 400)
                .background(Color.yellow)
                .onDisappear {
                    vm.rejig()
                }
            Text(vm.nextNumber.description).tag(2)
//                .frame(width: 400, height: 400)
                .background(Color.blue)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
    }
}

@Observable
class TabViewTestViewModel {
    var selectedIndex: Int = 1
    var currentNumber: Int = 100
    var previousNumber: Int {
        currentNumber - 1
    }
    var nextNumber: Int {
        currentNumber + 1
    }
    
    func rejig() {
        if selectedIndex == 0 {
            currentNumber = previousNumber
            selectedIndex = 1
        } else if selectedIndex == 2 {
            currentNumber = nextNumber
            selectedIndex = 1
        }
    }
}

#Preview {
    TabViewTest()
}
