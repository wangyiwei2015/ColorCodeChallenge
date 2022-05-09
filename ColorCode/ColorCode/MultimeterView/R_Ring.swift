import SwiftUI

struct ResistorRing: View {
    @Binding var ringColorIndex: [Int]
    var body: some View {
        GeometryReader {geo in
            ZStack {
                LinearGradient(colors: [Color(UIColor.systemGray4), Color(UIColor.systemGray)], startPoint: .top, endPoint: .bottom)
                HStack {
                    ForEach(0..<ringColorIndex.count, id: \.self) {index in
                        LinearGradient(
                            gradient: rRingColors[ringColorIndex[index]], 
                            startPoint: .top, endPoint: .bottom
                        ).mask(Rectangle()
                                .frame(width: 8)
                                .padding(.horizontal, 5)
                        )
                    }
                    ForEach(1...3, id: \.self) {num in
                        if ringColorIndex.count < num {
                            Color.clear
                                .frame(width: 20)
                                .padding(.horizontal, 5)
                        }
                    }
                }.padding(.horizontal)
            }.mask(RDIPShape())
        }
    }
}

struct RDIPShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path {path in
            let w = rect.width
            let h = rect.height
            path.addRect(CGRect(x: h / 2, y: h * 0.1, width: w - h, height: h * 0.8))
            path.addEllipse(in: CGRect(x: 0, y: 0, width: h, height: h))
            path.addEllipse(in: CGRect(x: w - h, y: 0, width: h, height: h))
        }
    }
}
