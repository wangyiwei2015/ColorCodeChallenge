import SwiftUI

struct QuizButtonStyle: ButtonStyle {
    var systemImage: String? = nil
    var width: CGFloat = 200
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            if let img = systemImage {
                Image(systemName: img)
            }
            configuration.label
        }
        .font(.system(size: 20))
        .foregroundColor(.white)
        .padding(.vertical, 10)
        .frame(width: width)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill().foregroundColor(.accentColor)
        )
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct QuizGameButtonStyle: ButtonStyle {
    var width: CGFloat = 120
    var height: CGFloat = 60
    var color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 22))
            .foregroundColor(.primary)
            .padding(.vertical, 10)
            .frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill().foregroundColor(color)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

extension AnyTransition {
    static func card(angle: Angle) -> AnyTransition {
        AnyTransition.modifier(
            active: Rotation(angle: angle, anchor: .bottom, opacity: 0.0),
            identity: Rotation()
        )
    }
}

struct Rotation: ViewModifier {
    var angle: Angle = Angle(degrees: 0)
    var anchor: UnitPoint = .center
    var opacity: Double = 1.0
    
    func body(content: Content) -> some View {
        content.rotationEffect(angle, anchor: anchor)
            .opacity(opacity)
    }
}
