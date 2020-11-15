import SwiftUI

struct ActionView: View {
    let button: CalculatorButton
    @Binding var state: CalculationState
    
    var body: some View {
        Button(action: {
            self.tapped()
        }, label: {
            Text(button.rawValue)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                .background(button.backgroundColor)
                .cornerRadius(buttonHeight() - 50)
        })
    }
    
    func buttonHeight() ->CGFloat{
        return (UIScreen.main.bounds.width - 5 * 10)/4
    }
    
    func buttonWidth(button:CalculatorButton) -> CGFloat{
        if button == .zero{
            return (UIScreen.main.bounds.width - 4 * 10)/4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 10)/4
    }
    
    func tapped(){
        switch button {
        case .ac:
            state.currentNumber = 0
            state.storedNumber = nil
            state.storedAction = nil
        case .equals:
            guard let storedAction = state.storedAction else { return}
            guard let storedNumber = state.storedNumber else { return}
            guard let result = storedAction.calculate(storedNumber, state.currentNumber) else {
                return
            }
            state.currentNumber = result
            state.storedNumber = nil
            state.storedAction = nil
            break
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero:
            if let number = Double(button.rawValue){
                state.appendNumber(number)
            }
        case.dot:
            //Not supported yet
            break
        case .percent:
            //Not supported yet
            break
        default:
            state.storedNumber = state.currentNumber
            state.currentNumber = 0
            state.storedAction = button
            break
        }
    }
}
