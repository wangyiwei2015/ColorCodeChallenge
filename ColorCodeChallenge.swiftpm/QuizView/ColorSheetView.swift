import SwiftUI

struct ColorSheetView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Color Cheatsheet").bold()
                    .padding(.vertical)
                HStack {
                    Color(UIColor.systemBackground)
                        .frame(width: 30, height: 40)
                    Text("Num").frame(width: 60).foregroundColor(.gray)
                    Text("Scale").frame(width: 60).foregroundColor(.gray)
                    Text("Tol.%").frame(width: 60).foregroundColor(.gray)
                }
                ForEach(0..<rRingColors.count, id: \.self) {index in
                    HStack {
                        LinearGradient(gradient: rRingColors[index], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .frame(width: 30, height: 30, alignment: .center)
                            .mask(Circle())
                        Text(index < 10 ? "\(index)" : "-").frame(width: 60)
                        Text(index < 10 ? "10^\(index)" : "10^\(9-index)").frame(width: 60)
                        Text(rRingErrors[index] == "?" ? "-" : "\(rRingErrors[index])%")
                    }
                }
            }.padding()
        }
    }
}
