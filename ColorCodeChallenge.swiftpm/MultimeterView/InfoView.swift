import SwiftUI

struct InfoView: View {
    let numericInfo: [Text] = [
        Text("0\n\n0\n\n-"),
        Text("1\n\n1\n\n1"),
        Text("2\n\n2\n\n2"),
        Text("3\n\n3\n\n-"),
        Text("4\n\n4\n\n-"),
        Text("5\n\n5\n\n.5"),
        Text("6\n\n6\n\n.25"),
        Text("7\n\n7\n\n.1"),
        Text("8\n\n8\n\n.05"),
        Text("9\n\n9\n\n-"),
        Text("-\n\n-1\n\n5"),
        Text("-\n\n-2\n\n10"),
    ]
    var body: some View {
        VStack {
            Text("↓ swipe to dismiss").font(.title3)
                .foregroundColor(.gray)
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        LeftLabel("shippingbox.fill", "Usage")
                        Text("Type in the values (numbers or colors) to identify the resistance.")
                    }
                    
                    Group {
                        Divider()
                        LeftLabel("number.circle.fill", "Numeric Representations")
                        Text("As SMD devices are tiny, engineers need to identify their values with as few numbers as possible. These are some of the rules:\n  • 'R', 'k', 'M'... replaces a floating point and the unit of (Ω, kΩ, MΩ, etc.), for example 6R8 = 6.8Ω and 4k7 = 4.7kΩ;\n  • A pure-number code uses its last digit as exponent, for example 103 = 10*10e+3 = 10k Ohm.")
                        Divider()
                    }
                    
                    LeftLabel("paintpalette.fill", "Resistor Color Code Basis")
                    Text("Each color represents a number.")
                    ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                        Group {
                            VStack {
                                Circle().fill()
                                    .foregroundColor(Color(UIColor.systemBackground))
                                    .frame(width: 30, height: 30)
                                Text("Num\n\nScale\n\nTol%")
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                            }
                        }
                        ForEach(0..<rRingColors.count, id:\.self) {index in
                            VStack {
                                LinearGradient(gradient: rRingColors[index], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .mask(Circle())
                                numericInfo[index]
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }}.frame(height: 160)
                    Text("When there are only 3 bands, simply use the second rule above. Its tolerance is ±20%.\nWhen there are 4 or 5 bands, the last digit is used to indicate tolerance. Then apply the rule above to the other digits.\n6-band resistors have an additional temperature coefficient, which is rarely used.")
                    
                    Group {
                        Divider()
                        LeftLabel("swift", "About The Project")
                        Text("This project is originally built with iPad after the release of the new Playgrounds as an IDE. Then Xcode on M1 Mac is used to accelerate further development. The icon was designed with Sketch on macOS.")
                        Spacer(minLength: 20)
                    }
                }.padding()
            }
        }
    }
}
