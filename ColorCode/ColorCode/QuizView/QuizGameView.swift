//
//  SwiftUIView.swift
//  
//
//  Created by wyw on 2022/4/20.
//

import SwiftUI

struct QuizGameView: View {
    @Binding var bestTimeSec: Double
    @Binding var gameMode: GameMode
    
    @State var questionIndex = 0
    @State var heart = 3
    @State var currentQuiz: QuizData? = nil
    @State var btnColors: [Color] = [Color](
        repeating: Color(UIColor.systemGray5), count: 4
    )
    let startTime = Date()
    @State var timeUsed: TimeInterval = 0
    
    var body: some View {
        ZStack {
            VStack { //top bar
                topBar()
                Spacer()
            }
            VStack { //Q-area
                Spacer()
                if heart > 0 {
                    if !gameEnded {question()}
                    else {winView()}
                } else {loseView()}
                Spacer()
            }
            VStack { //A-area
                Spacer()
                if !gameEnded {answers()}
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill().foregroundColor(.back)
                .shadow(color: Color(UIColor(white: 0, alpha: 0.4)), radius: 4, x: 0, y: 3)
        )
        .padding()
        .transition(.asymmetric(
            insertion: .opacity.combined(with: .scale(scale: 0.9)),
            removal: .card(angle: Angle(degrees: -8)).combined(with: .offset(x: -40, y: 100))
        ))
        .onAppear {
            nextQues()
            staticDataOrder.shuffle()
        }
    }
    
    @ViewBuilder func topBar() -> some View {
        HStack(spacing: 0) {
            Group {
                Image(systemName: heart > 0 ? "heart.fill" : "heart")
                Image(systemName: heart > 1 ? "heart.fill" : "heart")
                Image(systemName: heart > 2 ? "heart.fill" : "heart")
            }.foregroundColor(.red)
            Spacer()
            Text(gameEnded ? "_win" : "\(questionIndex)/\(levelCounts[gameMode.rawValue])")
                .font(.system(size: 20, weight: .regular, design: .monospaced))
            Spacer()
            Button {
                if timeUsed > 0 {
                    if bestTimeSec == 0 || timeUsed < bestTimeSec {
                        bestTimeSec = timeUsed
                        UserDefaults.standard.set(
                            timeUsed, forKey: defaultsKeys[gameMode.rawValue]
                        )
                    }
                }
                withAnimation(.easeInOut(duration: 0.2)) {
                    gameMode = .none
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundColor(.gray)
            }
        }
    }
    
    @ViewBuilder func question() -> some View {
        VStack {
            if let quiz = currentQuiz {
                let colors = quiz.0
                if colors.count == 1 {
                    LinearGradient(gradient: rRingColors[colors[0]], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 50, height: 50, alignment: .center)
                        .mask(Circle())
                } else {
                    ResistorRing(ringColorIndex: .constant(colors))
                        .frame(width: 140, height: 50)
                }
                VStack {
                    Text("\(localized("_the")) \(colors.count == 1 ? "\(localized("_color"))" : "\(localized("_resistor"))") \(localized("_above_show"))")
                    HStack {
                        Text(quiz.1.description)
                            .bold()
                            .foregroundColor(.accentColor)
                        Text("_of")
                    }
                }
                .font(.system(size: 20))
                .padding(.vertical, 30)
            } else {
                Image(systemName: "moon.circle")
                    .resizable().scaledToFit()
                    .foregroundColor(Color(UIColor.systemGray5))
                    .frame(width: 100, height: 100)
            }
        }
    }
    
    @ViewBuilder func answers() -> some View {
        VStack(spacing: 20) {
            ForEach(0...1, id: \.self) {row in
                HStack(spacing: 20) {
                    ForEach(0...1, id: \.self) {col in
                        let index = row * 2 + col
                        Button(currentQuiz?.2[index] ?? "--") {
                            userTaps(on: index)
                        }.buttonStyle(QuizGameButtonStyle(
                            color: btnColors[index]
                        ))
                    }
                }
            }
        }.padding(.bottom)
    }
    
    @ViewBuilder func loseView() -> some View {
        VStack {
            Spacer()
            Image(systemName: "ladybug")
                .resizable().scaledToFit()
                .foregroundColor(Color(UIColor.systemGray5))
                .frame(width: 100, height: 100)
                .padding()
            Text("_lose").font(.title2)
            Text("_lose_tip")
                .padding()
            Spacer(minLength: 160)
        }
    }
    
    @ViewBuilder func winView() -> some View {
        VStack {
            ZStack {
                Text("🏆").font(.system(size: 100))
            }.frame(width: 120, height: 120)
            Text(timeUsed < bestTimeSec ? "New Best!" : " ")
                .font(.title).foregroundColor(.green)
                .padding()
            Text("\(localized("_time_used")): \(String(format: "%1.1f", timeUsed)) \(localized("_sec"))")
            Text("\(localized("_best")): \(String(format: "%1.1f", bestTimeSec)) \(localized("_sec"))")
        }.onAppear {timeUsed = abs(startTime.timeIntervalSinceNow)}
    }
    
    let levelCounts: [Int] = [10, 12, 10, 8, 999] //10 12 8 10
    var gameEnded: Bool {
        questionIndex > levelCounts[gameMode.rawValue]
    }
    
    func userTaps(on index: Int) {
        guard heart > 0 else {return}
        if let quiz = currentQuiz {
            if quiz.3 == index {
                btnColors[index] = .green
                if !gameEnded {
                    nextQues()
                }
            } else {
                btnColors[index] = .red
                heart -= 1
            }
        }
    }
    
    func nextQues() {
        withAnimation(.linear(duration: 0.3)) {
            btnColors = [Color](
                repeating: Color(UIColor.systemGray5), count: 4
            )
            questionIndex += 1
            currentQuiz = QuizLevel.generate(questionIndex, for: gameMode)
        }
    }
}

enum QuestionType: Int {
    case none, value, scale, tolerance
    var description: String {
        switch self {
        case .none:
            return "<error>"
        case .value:
            return localized("_value")
        case .scale:
            return localized("_scale")
        case .tolerance:
            return localized("_tolerance")
        }
    }
}
