//
//  File.swift
//  ColorRingChallenge
//
//  Created by wyw on 2022/4/20.
//

import SwiftUI

struct IntroView: View {
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    Text("Welcome").font(.title)
                        .padding()
                    Divider()
                    VStack(alignment: .leading, spacing: 20) {
                        Text("The game is about colors on resistors.")
                        Group {
                            LeftLabel("stopwatch", "Chanllenges")
                            Text("There are 4 levels to chanllenge. Try to select the correct values as fast as possible.")
                            Text("Knowledge in electronics is related, but not required. Don't worry, as the tools below are always available.")
                        }
                        Divider()
                        Group {
                            LeftLabel("speedometer", "Multimeter")
                            Text("You can get the properties of a resistor by typing its color or silk (for SMD*). Note that the values you input may not exist in the real world.")
                            Text("* Surface mounted devices").foregroundColor(.gray)
                        }
                        Divider()
                        Group {
                            LeftLabel("text.book.closed", "Cheatsheet")
                            Text("Quickly look up for values of the colors.")
                        }
                    }
                }
            }
            Button {//It doesn't matter if you don't have experience in electronics.
                mode.wrappedValue.dismiss()
            } label: {
                Text("Start").bold()
                    .foregroundColor(.white)
            }.buttonStyle(QuizGameButtonStyle(width: 220, height: 50, color: .accentColor))
        }
    }
}
