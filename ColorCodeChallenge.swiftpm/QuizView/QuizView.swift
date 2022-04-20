import SwiftUI

struct QuizView: View {
    @State var bestScores: [Double] = [
        UserDefaults.standard.double(forKey: defaultsKeys[0]),
        UserDefaults.standard.double(forKey: defaultsKeys[1]),
        UserDefaults.standard.double(forKey: defaultsKeys[2]),
        UserDefaults.standard.double(forKey: defaultsKeys[3]),
        0,
    ]
    @State var gameMode: GameMode = .none
    
    var body: some View {
        ZStack {
            VStack {
                Group {
                    Text("Best Scores").bold().padding(.bottom)
                    Text("Easy: \(bestScores[0] > 0 ? "\(String(format: "%1.1f", bestScores[0]))s" : "None")")
                    Text("Med: \(bestScores[1] > 0 ? "\(String(format: "%1.1f", bestScores[1]))s" : "None")")
                    Text("Hard: \(bestScores[2] > 0 ? "\(String(format: "%1.1f", bestScores[2]))s" : "None")")
                    Text("Expert: \(bestScores[3] > 0 ? "\(String(format: "%1.1f", bestScores[3]))s" : "None")")
                }.font(.system(size: 22))
                Button("🙃 Play easy") {
                    startGame(.easy)
                }.buttonStyle(QuizButtonStyle())
                    .padding(.top, 40)
                Button("🤔 Play medium") {
                    startGame(.medium)
                }.buttonStyle(QuizButtonStyle())
                    .padding(.top, 10)
                Button("🤯 Play hard") {
                    startGame(.hard)
                }.buttonStyle(QuizButtonStyle())
                    .padding(.top, 10)
                Button("☠️ Play expert") {
                    startGame(.expert)
                }.buttonStyle(QuizButtonStyle())
                    .padding(.top, 10)
            }
            
            if gameMode != .none {
                QuizGameView(bestTimeSec: $bestScores[gameMode.rawValue], gameMode: $gameMode)
            }
        }
    }
    
    func startGame(_ difficulty: GameMode) {
        withAnimation(.easeInOut(duration: 0.2)) {
            gameMode = difficulty
        }
    }
}

let defaultsKeys: [String] = [
    "_BEST_EASY",
    "_BEST_MEDIUM",
    "_BEST_HARD",
    "_BEST_EXPERT",
]

enum GameMode: Int {
    case easy, medium, hard, expert, none
}
