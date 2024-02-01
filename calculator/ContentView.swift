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
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case decimal = "."
    case equal = "="
    case plus = "+"
    case minus = "-"
    case multiply = "X"
    case divide = "÷"
    case percent = "%"
    case toggleSign = "+/-"
    case clear = "C"
    
    var buttonColor: Color {
        switch self {
        case .divide, .multiply, .minus, .plus, .equal:
            return .orange
        case .clear, .toggleSign, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
    
    var textColor: Color {
        switch self {
        case .clear, .toggleSign, .percent:
            return .black
        default:
            return .white
        }
    }
}

struct ContentView: View {
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .toggleSign, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        
        @State var value = "0"
        
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("0")
                        .font(.system(size: 64))
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text(button.rawValue)
                                    .frame(width: buttonWidth(button: button), height: buttonHeight(button: button))
                                
                            })
                            .font(.system(size: 32))
                            .frame(width: buttonWidth(button: button), height: buttonHeight(button: button))
                            
                            .background(button.buttonColor)
                            .foregroundColor(button.textColor)
                            .cornerRadius(35)
                            
                            
                        }
                    }
                    .padding()
                }
            }
            
        }
    }
    
    func didTap(button: CalculatorButton) {
        
    }
    
    func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return 160
        }
        return 70
    }
    
    func buttonHeight(button: CalculatorButton) -> CGFloat {
        return 70
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
