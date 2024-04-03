import SwiftUI

struct ContentView: View {
    @State private var displayText = "0"
    @State private var firstOperand = 0.0
    @State private var secondOperand = 0.0
    @State private var operation = ""
    let buttons = [
        ["C", "8", "Del", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "x"],
        ["7", "0", "9", "/"],// Replaced "." with "Del" for backspace
        ["=", "."]
    ]
    var body: some View {
        ZStack {
            Color.black
        VStack {
            Text(displayText)
                .font(.title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                           // self.updateDisplay()
                        }) {
                            if button == "C" || button == "Del" {
                                Text(button)
                                    .font(.title)
                                    .frame(width: 80, height: 80)
                                    .background(button == "C" ? Color.red : Color.green)
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                            } else {
                                Text(button)
                                    .font(.title)
                                    .frame(width: 80, height: 80)
                                    .background(Color.green)
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
        }
        .padding()
        .background(Color.black)
    }
    
    func buttonTapped(_ button: String) {
        switch button {
        case "0"..."9":
            if displayText == "0" || displayText == "0.0" {
                displayText = button
            } else if operation.isEmpty{
                displayText += button //Allow multi-digit numbers without leading space
            }
            else {
                if displayText.last?.isNumber == true {
                    displayText += button
                }
                else {
                displayText += " " + button
                }
            }
            
        case "+", "-", "x", "/":
            if displayText.last?.isNumber == true {
                displayText += " \(button)"
            } else if displayText.count > 1 {
                displayText.removeLast()
                displayText += "\(button)"
            }
            operation = button
        case "=":
            if !operation.isEmpty {
                let expression = displayText.replacingOccurrences(of: "x", with: "*")
                let result = NSExpression(format: expression).expressionValue(with: nil, context: nil) as? Double ?? 0
                
                if result.truncatingRemainder(dividingBy: 1) == 0 {
                    displayText = "\(Int(result))"
                }
                else {
                    displayText = "\(result)"
                }
                operation = ""
            }
            secondOperand = Double(displayText) ?? 0
            switch operation {
            case "+":
                displayText = "\(firstOperand + secondOperand)"
            case "-":
                displayText = "\(firstOperand - secondOperand)"
            case "x":
                displayText = "\(firstOperand * secondOperand)"
            case "/":
                displayText = "\(firstOperand / secondOperand)"
            default:
                break
            }
        case ".":
            // Handle decimal point logic
            break
        case "C":
            displayText = "0"
            operation = ""
        case "Del":
            if displayText.count > 1 {
                displayText.removeLast()
            } else {
                displayText = "0"
            }
        default:
            break
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/* func updateDisplay () {
    let padding = max(0, 10 - displayText.count)
    
    let paddedText = String(repeating: " ", count: padding) + displayText
    
    displayLabel.text = paddedText
} */
