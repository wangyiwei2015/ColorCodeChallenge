//
//  File.swift
//  
//
//  Created by wyw on 2022/4/20.
//

import SwiftUI

//struct LeftLabel: View {
//    @State var img = ""
//    @State var text = ""
//
//    init(_ img: String, _ text: String) {
//        self.img = img
//        self.text = text
//    }
//
//    var body: some View {
//        HStack {
//            Image(systemName: img)
//                .font(.system(size: 30, weight: .semibold))
//                .foregroundColor(.accentColor)
//            Text(text).bold()
//            Spacer()
//        }
//    }
//}

@ViewBuilder
func LeftLabel(_ img: String, _ text: String) -> some View {
    HStack {
        Image(systemName: img)
            .font(.system(size: 30, weight: .semibold))
            .foregroundColor(.accentColor)
        Text(text).bold()
        Spacer()
    }
}
