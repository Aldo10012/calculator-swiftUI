import SwiftUI

struct CalculationState{
    var currentNumber: Double = 0
    var storedNumber: Double?
    var storedAction: CalculatorButton?
    
    mutating func appendNumber(_ number: Double){
        if number.truncatingRemainder(dividingBy: 1) == 0 && currentNumber.truncatingRemainder(dividingBy: 1) == 0 {
            currentNumber = 10 * currentNumber + number
            print("Current number: \(currentNumber)")
        }
        else {
            currentNumber = number
        }
    }
}

enum CalculatorButton: String{
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
    case plus = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "/"
    case equals = "="
    case ac = "AC"
    case plusMinus = "+/-"
    case percent = "%"
    case dot = "."
    
    var backgroundColor: Color{
        switch self {
        case .plus, .minus, .multiply, .divide, .equals:
            return Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        case .ac, .plusMinus, .percent:
            return Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
        default:
            return Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        }
    }
    
    func calculate(_ input1: Double, _ input2: Double) -> Double?{
        switch self {
        case .plus:
            return input1 + input2
        case .minus:
            return input1 - input2
        case .multiply:
            return input1 * input2
        case .divide:
            return input1 / input2
        default:
            return nil
        }
    }
}
    

struct ContentView: View {
    
    @State var state = CalculationState()
    var displayText: String{
        return String(format: "%.2f", state.currentNumber)
    }
    
    let buttonOptions: [[CalculatorButton]] = [
        [.ac,     .plusMinus, .percent,  .divide],
        [.seven,  .eight,     .nine,     .multiply],
        [.four,   .five,      .six,      .minus],
        [.one,    .two,       .three,    .plus],
        [.zero,   .dot,       .equals]
    ]
    
    var body: some View {
        VStack(spacing:10){
            HStack{
                Spacer()
                Text(displayText)
                    .font(.largeTitle)
            }
            
            ForEach(buttonOptions, id: \.self){ row in
                // what happens in each row
                HStack{
                    ForEach(row, id:\.self){ button in
                        ActionView(button: button, state: $state)
                    }
                }
            }
            
        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom).padding(10)
    }
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
