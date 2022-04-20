import SwiftUI

struct PrefsView: View {
    @Environment(\.presentationMode) var mode
    @State var showsShare = false
    
    let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    let appURL = URL(string: "https://apps.apple.com/cn/app/resistor-identifier/id1604042855")!
    let reviewURL = URL(string: "itms-apps://itunes.apple.com/app/id1604042855?action=write-review")!
    let githubURL = URL(string: "https://github.com/wangyiwei2015/Resistor-support/issues")!
    let emailAdd = URL(string: "mailto:wangyw.dev@outlook.com?subject=Feedback_R_\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)")!
    
    var body: some View {
        VStack {
            Text("↓ swipe to dismiss").font(.title3)
            .foregroundColor(.gray)
            Spacer()
            prefButton(systemImg: "square.and.arrow.up.fill",
                color: .green, title: "Share this app"
            ) {showsShare = true}
            prefButton(systemImg: "star.fill",
                color: .blue, title: "Review"
            ) {openURL(reviewURL)}
            prefButton(systemImg: "exclamationmark.circle.fill",
                color: .orange, title: "Submit issues"
            ) {openURL(githubURL)}
            prefButton(systemImg: "envelope.badge.fill",
                color: .blue, title: "Contact"
            ) {openURL(emailAdd)}
            prefButton(systemImg: "gearshape.fill",
                color: .gray, title: "Settings"
            ) {openURL(URL(string: UIApplication.openSettingsURLString)!)}
            Spacer()
            Text("v\(version)").foregroundColor(.gray)
                .padding(.bottom, 3)
            HStack {
                Text("Made with")
                Label("SwiftUI", systemImage: "swift")
            }.foregroundColor(.gray)
        }.padding()
            .popover(isPresented: $showsShare, content: {ShareView(appURL)})
    }
    
    func openURL(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @ViewBuilder
    func prefButton(systemImg: String, color: Color = .accentColor, title: String, action: @escaping (() -> Void)) -> some View {
        Button(action: action, label: {
            HStack {
                Image(systemName: systemImg)
                    .foregroundColor(color).padding()
                Text(title).foregroundColor(.primary)
                Spacer()
            }.font(.title3)
                //.frame(width: 250, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundColor(.back)
                        .shadow(color: Color(UIColor.systemGray4), radius: 6, y: 3)
                ).padding(.vertical, 8)
        })
    }
}
