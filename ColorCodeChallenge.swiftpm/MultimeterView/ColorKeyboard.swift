import SwiftUI

struct ColorKeyboard: View {
    @Binding var value: [Int]
    @Binding var showNumbers: Bool
    var inputState: InputState {
        if value.count < 2 {return .value}
        else if value.count < 4 {return .scale}
        else if value.count == 4 {return .error}
        else {return .full}
    } //val scale error(tolerance)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(.back)
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
        HStack {
            if row == 0 {
                KeyboardButton(title: "C", backGrad: rRingColors[8]) {
                    modifyRings(-2)
                }
            }
            ForEach(0...2, id: \.self) {col in
                KeyboardButton(title: showNumbers ? "\(row * 3 + col)" : " ", backGrad: rRingColors[row * 3 + col]) {
                    modifyRings(row * 3 + col)
                }
            }
            if row == 0 {
                KeyboardButton(title: "←", backGrad: rRingColors[8]) {
                    modifyRings(-1)
                }
            }
        }
    }
}

extension ColorKeyboard {
    enum InputState: Int {
        case value, scale, error, full
    }
}

extension ColorKeyboard {
    func modifyRings(_ buttonIndex: Int) {
        switch buttonIndex {
        case -1:
            if !value.isEmpty {_ = value.popLast()}
        case -2:
            value = []
        default:
            if inputState == .full {return}
            value.append(buttonIndex)
        }
    }
}

struct KeyboardButton: View {
    let title: String
    let backGrad: Gradient
    let action: () -> Void
    var body: some View {
        Button {action()}
        label: {
            Text(title)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .background(
                    LinearGradient(gradient: backGrad, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 40, height: 40, alignment: .center)
                        .mask(
                            Circle()
                        )
                )
                .frame(width: 40, height: 40, alignment: .center)
        }.shadow(radius: 2)
    }
}
