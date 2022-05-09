import SwiftUI

extension UIScreen {
    var ratioWH: CGFloat {
        bounds.width / bounds.height
    }
}

extension Color {
    static let back = Color(UIColor.systemBackground)
}

struct ShareView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController
    
    var controller: UIViewControllerType!
    init(_ url: URL) {
        controller = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        let w = UIScreen.main.bounds.width
        controller.popoverPresentationController?.sourceRect = CGRect(
            x: w / 2, y: 50,
            width: 0, height: 0
        )
    }
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}

func localized(_ key: String) -> String {
    NSLocalizedString(key, comment: "")
}
