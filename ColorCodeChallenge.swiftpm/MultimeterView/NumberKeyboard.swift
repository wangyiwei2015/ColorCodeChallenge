import SwiftUI

struct NumberKeyboard: View {
    @Binding var value: String
    let keypadTitles: [String] = [
        "C","7","8","9","←",
        "4","5","6",
        "1","2","3",
        "R","0","R",
    ]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(Color(UIColor.systemBackground))
                .shadow(radius: 8)
            //main
            VStack {
                ForEach(0...3, id: \.self) {row in
                    MakeRows(row)
                }
            }
        }.frame(width: 250, height: 200)
            .padding(.bottom)
    }
    
    @ViewBuilder
    func MakeRows(_ row: Int) -> some View {
        if row == 0 {
            HStack {
                NumKeyboardButton(
                    title: keypadTitles[0],
                    specialFunction: true
                ) {modifyVal(0)}
                ForEach(1...3, id: \.self) {col in
                    NumKeyboardButton(title: keypadTitles[col]) {
                        modifyVal(col)
                    }
                }
                NumKeyboardButton(
                    title: keypadTitles[4],
                    specialFunction: true
                ) {modifyVal(4)}
            }
        } else {
            HStack {
                ForEach(0...2, id: \.self) {col in
                    NumKeyboardButton(title: keypadTitles[2 + row * 3 + col]) {
                        modifyVal(row * 5 + col)
                    }
                }
            }
        }
    }
}

extension NumberKeyboard {
    func modifyVal(_ buttonIndex: Int) {
        if(value.count == 4 && buttonIndex != 0 && buttonIndex != 4) {return}
        switch buttonIndex {
        case 0: value = ""
        case 1,2,3: value += String(buttonIndex + 6)
        case 4: if !value.isEmpty {value.popLast()}
        case 5,6,7: value += String(buttonIndex - 1)
        case 10,11,12: value += String(buttonIndex - 9)
        case 11,12,13: value += String(buttonIndex - 10)
        case 15,17: value += "R"
        case 16: value += "0"
        default: fatalError()
        }
    }
}

struct NumKeyboardButton: View {
    let title: String
    var specialFunction: Bool = false
    let action: () -> Void
    var body: some View {
        Button {action()}
    label: {
        Text(title)
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .foregroundColor(specialFunction ? .white : .secondary)
            .background(
                Color(specialFunction ? UIColor.systemGray : UIColor.systemGray4)
                    .frame(width: 40, height: 40, alignment: .center)
                    .mask(Circle())
            )
            .frame(width: 40, height: 40, alignment: .center)
    }.shadow(radius: 2)
    }
}
