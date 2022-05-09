import SwiftUI

struct InfoView: View {
    let numericInfo: [Text] = [
        Text("0\n\n0\n\n-"),
        Text("1\n\n1\n\n1"),
        Text("2\n\n2\n\n2"),
        Text("3\n\n3\n\n-"),
        Text("4\n\n4\n\n-"),
        Text("5\n\n5\n\n.5"),
        Text("6\n\n6\n\n.25"),
        Text("7\n\n7\n\n.1"),
        Text("8\n\n8\n\n.05"),
        Text("9\n\n9\n\n-"),
        Text("-\n\n-1\n\n5"),
        Text("-\n\n-2\n\n10"),
    ]
    var body: some View {
        VStack {
            Text("_dsms_msg").font(.title3)
                .foregroundColor(.gray)
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        LeftLabel("shippingbox.fill", localized("_Usage"))
                        Text("_usg_desc")
                    }
                    
                    Group {
                        Divider()
                        LeftLabel("number.circle.fill", localized("_numr"))
                        Text("_numr_desc")
                        Divider()
                    }
                    
                    LeftLabel("paintpalette.fill", localized("_colorcode_t"))
                    Text("_colorcode_desc")
                    ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                        Group {
                            VStack {
                                Circle().fill()
                                    .foregroundColor(.back)
                                    .frame(width: 30, height: 30)
                                Text("Num\n\nScale\n\nTol%")
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.gray)
                            }
                        }
                        ForEach(0..<rRingColors.count, id:\.self) {index in
                            VStack {
                                LinearGradient(gradient: rRingColors[index], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .mask(Circle())
                                numericInfo[index]
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }}.frame(height: 160)
                    Text("_colorcode_desc_2")
                    
                    Group {
                        Divider()
                        LeftLabel("swift", localized("_about"))
                        Text("_proj_desc")
                        Spacer(minLength: 20)
                    }
                }.padding()
            }
        }
    }
}
