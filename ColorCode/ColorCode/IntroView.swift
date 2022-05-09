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
                    Text("_Welcome").font(.title)
                        .padding()
                    Divider()
                    VStack(alignment: .leading, spacing: 20) {
                        Text("_desc")
                        Group {
                            LeftLabel("stopwatch", "\(localized("_Challenges"))")
                            Text("_cha_desc_1")
                            Text("_cha_desc_2")
                        }
                        Divider()
                        Group {
                            LeftLabel("speedometer", "\(localized("_Multimeter"))")
                            Text("_meter_desc")
                            Text("_smt").foregroundColor(.gray)
                        }
                        Divider()
                        Group {
                            LeftLabel("text.book.closed", "\(localized("_Cheatsheet"))")
                            Text("_cheatsheet_desc")
                        }
                    }
                }.padding()
            }
            Button {//It doesn't matter if you don't have experience in electronics.
                mode.wrappedValue.dismiss()
            } label: {
                Text("_Start").bold()
                    .foregroundColor(.white)
            }.buttonStyle(QuizGameButtonStyle(width: 220, height: 50, color: .accentColor))
                .padding()
        }
    }
}
