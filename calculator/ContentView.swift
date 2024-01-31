//
//  ContentView.swift
//  calculator
//
//  Created by Chase Rensberger on 1/30/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

enum CalculatorButton: String {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case decimal
    case equals
    case plus
    case minus
    case multiply
    case divide
    case percent
    case toggleSign
    case clear
}

struct ContentView: View {
    
    let buttons: [[CalculatorButton]] = [
        [.seven, .eight, .nine]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Spacer()
                    Text("0")
                        .font(.system(size: 64))
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()

                ForEach(buttons, id: \.self) { row in
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            
                        }, label: {
                            Text(button.rawValue)
                                .frame(width: 70, height: 70)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(35)
                        })
                    }
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
