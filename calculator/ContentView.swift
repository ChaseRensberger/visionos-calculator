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
    case multiply = "×"
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
    
    @State private var value = "0" // Current display value
    @State private var runningNumber = 0.0 // Current running number
    @State private var currentOperation: CalculatorButton? = nil // Current operation
    private let maxDigits = 9;
    @State private var lastSelectedButton = CalculatorButton.clear
    
    let buttons: [[CalculatorButton]] = [
        [.clear, .toggleSign, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        
        
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(formatNumber(value))
                        .font(.system(size: 64))
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self.didTap(button: button)
                            }, label: {
                                Text(button.rawValue)
                                    .frame(width: buttonWidth(button: button), height: buttonHeight(button: button))
                                
                            })
                            .font(.system(size: 32))
                            .frame(width: buttonWidth(button: button), height: buttonHeight(button: button))
                            
                            .background(button.buttonColor)
                            .foregroundColor(button.textColor)
                            .cornerRadius(35)
                            .padding(2)
                            
                            
                        }
                    }
                    
                }
            }
            .padding()
            
        }
    }
    
    private func didTap(button: CalculatorButton) {
        switch button {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            if value == "0" || (currentOperation != nil && runningNumber != 0 && value == String(runningNumber)) {
                value = button.rawValue
            } else {
                value += button.rawValue
            }
        case .plus, .minus, .multiply, .divide:
            if currentOperation != nil && ![.plus, .minus, .multiply, .divide].contains(lastSelectedButton) {
                evaluate()
            }
            runningNumber = Double(value) ?? 0
            currentOperation = button
            if button != .equal {
                value = String(runningNumber)
            }
        case .equal:
            if ![.multiply, .divide, .minus, .plus, .equal].contains(lastSelectedButton){
                evaluate()
            }
        case .clear:
            value = "0"
            runningNumber = 0
            currentOperation = nil
        case .toggleSign:
            if value != "0" {
                value = value.hasPrefix("-") ? String(value.dropFirst()) : "-\(value)"
            }
        case .percent:
            if let currentValue = Double(value) {
                value = "\(currentValue / 100)"
            }
        }
        lastSelectedButton = button
    }
    
    private func evaluate() {
        let runningValue = runningNumber
        let currentValue = Double(value) ?? 0
        switch currentOperation {
        case .plus:
            value = "\(runningValue + currentValue)"
        case .minus:
            value = "\(runningValue - currentValue)"
        case .multiply:
            value = "\(runningValue * currentValue)"
        case .divide:
            value = currentValue != 0 ? "\(runningValue / currentValue)" : "Error"
        default:
            break
        }
        currentOperation = .equal
        runningNumber = Double(value) ?? 0
    }
    
    func formatNumber(_ numberString: String) -> String {
        // Create a NumberFormatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        
        guard let number = Double(numberString) else {
            print("Invalid input: \(numberString)")
            return numberString
        }
        
        guard let formattedNumber = formatter.string(from: NSNumber(value: number)) else {
            print("Number formatting failed for: \(number)")
            return numberString
        }
        
        return formattedNumber
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
