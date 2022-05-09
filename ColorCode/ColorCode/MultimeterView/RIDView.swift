import SwiftUI

struct RIDView: View {
    @State var ringColorIndex: [Int] = []
    @State var smtSilk: String = ""
    @State var usingSMT = false
    @State var showsPrefs = false
    @State var showsInfo = false
    @State var colorPadShowsNumbers: Bool = UserDefaults.standard.bool(forKey: "_NUM_ON_COLOR")
    
    @Namespace private var ns
    let defaultAnimation = Animation.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)
    let sharedBGColor: Color = Color(
        UIColor {$0.userInterfaceStyle == .dark ? UIColor.systemGray4 : UIColor.systemBackground
    })
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                MeterView(value: usingSMT ? smtValue : ringValue, errorIndex: usingSMT ? smtError : ringError)
                .frame(height: 200)
                TopButtons()
            }
            Spacer()
            Resistors()
            Spacer()
            if usingSMT {
                NumberKeyboard(value: $smtSilk)
                    .transition(.offset(y: 300))
            } else {
                ColorKeyboard(value: $ringColorIndex, showNumbers: $colorPadShowsNumbers)
                    .transition(.offset(y: 300))
            }
        }
        .sheet(isPresented: $showsPrefs, onDismiss: {
            colorPadShowsNumbers = UserDefaults.standard.bool(forKey: "_NUM_ON_COLOR")
        }) {PrefsView()}
        .sheet(isPresented: $showsInfo, onDismiss: nil, content: {InfoView()})
    }
    
    @ViewBuilder
    func Resistors() -> some View {
        //色环电阻
        ZStack {
            if !usingSMT {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .matchedGeometryEffect(id: "_sbg", in: ns)
                    .foregroundColor(sharedBGColor)
                    .shadow(radius: 5)
            }
            ResistorRing(ringColorIndex: $ringColorIndex)
                .frame(width: 140, height: 50)
                .shadow(radius: 8, y: 4)
                .padding().padding(.horizontal, 10)
                .onTapGesture {withAnimation(defaultAnimation){usingSMT = false}}
        }.frame(width: 140, height: 50).padding()
        //贴片电阻
        ZStack {
            if usingSMT {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .matchedGeometryEffect(id: "_sbg", in: ns)
                    .foregroundColor(sharedBGColor)
                    .shadow(radius: 5)
            }
            ResistorSMT(value: $smtSilk)
                .frame(width: 110, height: 50)
                .shadow(radius: 3, y: 3)
                .padding().padding(.horizontal, 25)
                .onTapGesture {withAnimation(defaultAnimation){usingSMT = true}}
        }.frame(width: 140, height: 50).padding()
    }
    
    @ViewBuilder
    func TopButtons() -> some View {
        VStack {
            HStack {
                Button {
                    showsPrefs = true
                } label: {
                    Image(systemName: "gear")
                        .font(.system(size: 24, weight: .regular))
                        .padding()
                }
                Spacer()
                Button {
                    showsInfo = true
                } label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 24, weight: .regular))
                        .padding()
                }
            }
            Spacer()
        }
    }
}
