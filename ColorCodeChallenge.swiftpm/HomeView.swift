import SwiftUI

struct HomeView: View {
    @State var showsMeter = false
    @State var showsColorSheet = false
    let device = UIDevice.current.userInterfaceIdiom
    @State var isFirstLaunch = !UserDefaults.standard.bool(forKey: "_LAUNCHED")
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Button {
                    isFirstLaunch = true
                } label: {
                    Text("- Read intro again -")
                        .bold().foregroundColor(.gray)
                }.padding(.bottom, 30)
            }
            VStack {
                Text("Color Code Challenge")
                    .font(.system(size: 20, weight: .bold))
                    .frame(height: 50)
                    .padding()
                Spacer()
                QuizView()
                Spacer()
            }
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .opacity(showsMeter || showsColorSheet ? 0.2 : 0.0)
                .animation(.easeInOut(duration: 0.3), value: showsMeter || showsColorSheet)
                .onTapGesture {
                    showsMeter = false
                    showsColorSheet = false
                }
            HidableMeterView()
            HidableColorSheetView()
        }.background(Color(UIColor.systemGray6))
            .sheet(isPresented: $isFirstLaunch, onDismiss: {
                UserDefaults.standard.set(true, forKey: "_LAUNCHED")
            }) {IntroView().padding()}
    }
    
    @ViewBuilder
    func HidableColorSheetView() -> some View {
        HStack(spacing: 0) {
            Spacer()
            VStack {
                Button {
                    showsColorSheet.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(Color(UIColor.systemBackground))
                        Image(systemName: "text.book.closed")
                            .font(.system(size: 30))
                    }.frame(width: 50, height: 50)
                }.padding()
                    .opacity(device == .phone && showsMeter ? 0.0 : 1.0)
                    .animation(.default, value: showsMeter)
                Spacer()
            }
            ColorSheetView().frame(width: 300)
                .background(Color(UIColor.systemBackground))
        }.offset(x: showsColorSheet ? 0 : 300)
            .animation(.easeInOut(duration: 0.3), value: showsColorSheet)
    }
    
    @ViewBuilder
    func HidableMeterView() -> some View {
        HStack(spacing: 0) {
            RIDView().frame(width: 300)
                .background(Color(UIColor.systemBackground))
            VStack {
                Button {
                    showsMeter.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(Color(UIColor.systemBackground))
                        Image(systemName: "speedometer")
                            .font(.system(size: 30))
                    }.frame(width: 50, height: 50)
                }.padding()
                    .opacity(device == .phone && showsColorSheet ? 0.0 : 1.0)
                    .animation(.default, value: showsColorSheet)
                Spacer()
            }
            Spacer()
        }.offset(x: showsMeter ? 0 : -300)
            .animation(.easeInOut(duration: 0.3), value: showsMeter)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
