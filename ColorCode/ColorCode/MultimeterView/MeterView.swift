import SwiftUI

struct MeterView: View {
    var value: Double
    var errorIndex: Int
    var num: Double {
        if scale == -3 {return 0}
        if scale == 3 {return 10}
        return value * pow(10.0, -Double(scale * 3))
    }
    var scale: Int {
        if value < 0.000001 {
            return -3
        } else if value < 0.001 {
            return -2 //u
        } else if value < 1 {
            return -1 //m
        } else if value < 1000 {
            return 0 //R
        } else if value < 1000000 {
            return 1 //K
        } else if value < 1000000000 {
            return 2 //M
        } else {
            return 3
        }
    }
    
    let g5 = Color(UIColor.systemGray5)
    let scaleStr: [String] = ["?","u","m","R","k","M","?"]
    
    var body: some View {
        ZStack {
            Numbers()
            Kedus()
            Hand()
            VStack {
                Spacer()
                HStack {
                    Text("u").foregroundColor(scale == -2 ? .accentColor : g5)
                    Text("m").foregroundColor(scale == -1 ? .accentColor : g5)
                    Text("R").foregroundColor(scale == 0 ? .accentColor : g5)
                    Text("K").foregroundColor(scale == 1 ? .accentColor : g5)
                    Text("M").foregroundColor(scale == 2 ? .accentColor : g5)
                }.font(.system(size: 20, weight: .regular, design: .monospaced))
                    .padding(5)
                Label("\(String(format: "%g", num))\(scaleStr[scale + 3])±\(rRingErrors[errorIndex])%", systemImage: "speedometer")
                    .font(.system(size: 20, weight: .semibold, design: .monospaced))
                    .foregroundColor(.gray)
                //.animation(.none)
            }
        }
    }
    
    @ViewBuilder
    func Numbers() -> some View {
        ForEach(0...10, id: \.self) {num in
            let degree: Double = 120 / 5 * (5 - Double(num))
            Text("\(min(num * 100,999))")
                .font(.system(size: 18, weight: .regular, design: .monospaced))
                .foregroundColor(.gray)
                .rotationEffect(Angle(degrees: degree))
                .offset(y: -100)
                .rotationEffect(Angle(degrees: -degree))
        }
    }
    
    @ViewBuilder
    func Kedus() -> some View {
        ForEach(0...10, id: \.self) {num in
            let degree: Double = 120 / 5 * (5 - Double(num))
            Capsule().foregroundColor(g5)
                .frame(width: 2, height: 15)
                .offset(y: -70)
                .rotationEffect(Angle(degrees: -degree))
        }
    }
    
    @ViewBuilder
    func Hand() -> some View {
        Capsule().foregroundColor(.accentColor)
            .frame(width: 4, height: 70)
            .offset(y: -35)
            .rotationEffect(Angle(degrees: 120 / 500 * (num - 500)))
            .shadow(radius: 2, y: 2)
            .animation(.spring(), value: num)
        Circle().foregroundColor(.accentColor)
            .frame(width: 10, height: 10)
            .shadow(radius: 2, y: 2)
    }
}
