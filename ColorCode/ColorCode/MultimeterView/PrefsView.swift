import SwiftUI

struct PrefsView: View {
    @Environment(\.presentationMode) var mode
    @State var showsShare = false
    @State var prefsNumberOnColor = UserDefaults.standard.bool(forKey: "_NUM_ON_COLOR")
    
    let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    let appURL = URL(string: "https://apps.apple.com/us/app/colorcode-challenge-resistor/id1622171134")!
    let reviewURL = URL(string: "itms-apps://itunes.apple.com/app/id1622171134?action=write-review")!
    let githubURL = URL(string: "https://github.com/wangyiwei2015/ColorCodeChallenge")!
    let emailAdd = URL(string: "mailto:wangyw.dev@outlook.com?subject=Feedback_R_\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)")!
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding()
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 20) {
                    Spacer(minLength: 20)
                    Toggle("_num_on_pad", isOn: $prefsNumberOnColor)
                        .font(.title3).padding(8)
                        .onChange(of: prefsNumberOnColor, perform: {value in
                            UserDefaults.standard.set(value, forKey: "_NUM_ON_COLOR")
                        })
                    prefButton(systemImg: "square.and.arrow.up.fill",
                        color: .green, title: "_share"
                    ) {showsShare = true}
                    prefButton(systemImg: "star.fill",
                        color: .blue, title: "_Review"
                    ) {openURL(reviewURL)}
                    prefButton(systemImg: "exclamationmark.circle.fill",
                        color: .orange, title: "_issue"
                    ) {openURL(githubURL)}
                    prefButton(systemImg: "envelope.badge.fill",
                        color: .blue, title: "_Contact"
                    ) {openURL(emailAdd)}
                    prefButton(systemImg: "gearshape.fill",
                        color: .gray, title: "_settings"
                    ) {openURL(URL(string: UIApplication.openSettingsURLString)!)}
                    Text("v\(version)").foregroundColor(.gray)
                        .padding(.bottom, 3)
                    HStack {
                        Text("Made with")
                        Label("SwiftUI", systemImage: "swift")
                    }.foregroundColor(.gray)
                }.padding(40)
            }
            Spacer()
        }//.padding()
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
                        .shadow(color: Color(UIColor(white: 0, alpha: 0.2)), radius: 4, y: 2)
                ).padding(.vertical, 8)
        }).buttonStyle(QuizGameButtonStyle(
            width: /*UIScreen.main.bounds.width * 0.75*/.infinity, color: .back
        ))
    }
}
