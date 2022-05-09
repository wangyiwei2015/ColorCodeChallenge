import SwiftUI

struct ResistorSMT: View {
    @Binding var value: String
    var body: some View {
        GeometryReader {geo in
            let rect = geo.frame(in: .local)
            ZStack {
                LinearGradient(
                    colors: [Color(UIColor.systemGray4), Color(UIColor.systemGray)], 
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                    .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .frame(width: rect.width, height: rect.height)
                Rectangle().foregroundColor(.black)
                    .frame(width: rect.width - 40, height: rect.height, alignment: .center)
                Text(value)
                    .font(.system(size: 25, weight: .regular, design: .monospaced))
                    .foregroundColor(.white)
            }
        }
    }
}
