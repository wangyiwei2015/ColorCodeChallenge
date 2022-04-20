import SwiftUI
import SafariServices

struct ColorSheetView: View {
    @State var showsWikiPage = false
    
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
                HStack {
                    Spacer()
                    Button {
                        showsWikiPage = true
                    } label: {
                        Label("Wikipedia", systemImage: "network")
                    }
                    Spacer()
                }.padding(.top, 40)
            }.padding()
                .sheet(isPresented: $showsWikiPage) {
                    SafariView(url: URL(string: "https://en.wikipedia.org/wiki/Electronic_color_code")!)
                }
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    var controller: SFSafariViewController!
    init(url: URL) {controller = SFSafariViewController(url: url)}
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return controller
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}
