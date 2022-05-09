import SwiftUI

let rRingColors: [Gradient] = {
    let basicColors: [Color] = [
        .init(white: 0.3), .brown, .red, .orange, .yellow, .green, .blue, .purple, .gray, .init(white: 0.93)
    ]
    var basicGrad = basicColors.map({Gradient(colors: [$0])})
    basicGrad.append(Gradient(colors: [.yellow, .white, .yellow, .orange, .yellow]))
    basicGrad.append(Gradient(colors: [.gray, .white, .gray, .black]))
    return basicGrad
}()
let rRingValues: [Int] = [0,1,2,3,4,5,6,7,8,9]
let rRingScales: [Int] = [0,1,2,3,4,5,6,7,8,9,-1,-2]
let rRingErrors: [String] = ["1","2","?","?","0.5","0.25","0.1","0.05","?","?","5","10","20"]

let rTable = [
    100, 102, 105, 107, 110, 113, 115, 118, 121, 124,
    127, 130, 133, 137, 140, 143, 147, 150, 154, 158,
    162, 165, 169, 174, 178, 182, 187, 191, 196, 200,
    205, 210, 215, 221, 226, 232, 237, 243, 249, 255,
    261, 267, 274, 280, 287, 294, 301, 309, 316, 324,
    332, 340, 348, 357, 365, 374, 383, 392, 402, 412,
    422, 432, 442, 453, 464, 475, 487, 499, 511, 523,
    536, 549, 562, 576, 590, 604, 619, 634, 649, 665,
    681, 698, 715, 732, 750, 768, 787, 806, 825, 845,
    866, 887, 908, 931, 953, 976,   0,   0,   0,   0,
]
let rTabelScale: [String:Double] = [
    "X": 0.1, "A": 1.0, "B": 10.0,
    "C": 100.0, "D": 1000.0, "E": 10000.0
]
