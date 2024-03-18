import SwiftUI

struct ContentView: View {
    @State private var displayText = "0"
    @State private var firstOperand = 0.0
    @State private var secondOperand = 0.0
    @State private var operation = ""
    let buttons = [
        ["7", "8", "9", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "x"],
        ["C", "0", "Del", "/", "="] // Replaced "." with "Del" for backspace
    ]
    
    var body: some View {
        VStack {
            Text(displayText)
                .font(.title)
                .padding()
            
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            if button == "C" || button == "Del" {
                                Text(button)
                                    .font(.title)
                                    .frame(width: 80, height: 80)
                                    .background(button == "C" ? Color.red : Color.gray)
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                            } else {
                                Text(button)
                                    .font(.title)
                                    .frame(width: 80, height: 80)
                                    .background(Color.gray)
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func buttonTapped(_ button: String) {
        switch button {
        case "0"..."9":
            if displayText == "0" {
                displayText = button
            } else {
                displayText += button
            }
        case "+", "-", "x", "/":
            firstOperand = Double(displayText) ?? 0
            operation = button
            displayText = "0"
        case "=":
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
        case "B":
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
