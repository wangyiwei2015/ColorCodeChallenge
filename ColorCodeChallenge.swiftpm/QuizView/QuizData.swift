//
//  File.swift
//  
//
//  Created by wyw on 2022/4/20.
//

import SwiftUI

typealias QuizData = ([Int], QuestionType, [String], Int)
                       //color(s), type, choices, ans
class QuizLevel {
    static func generate(_ qn: Int, for difficulty: GameMode) -> QuizData {
        switch difficulty {
        case .easy: //single color, value only, 10Q
            return makeRandomColorValue()
        case .medium:
            let typeRnd = arc4random() % 5
            if typeRnd == 0 {
                return makeRandomColorValue()
            } else if typeRnd < 3 {
                return makeRandomColorScale()
            } else {
                return makeRandomColorTolerance()
            }
        case .hard:
            let tempData = staticData3Band[staticDataOrder[qn]]
            return (tempData.0, .value, tempData.1, tempData.2)
        case .expert:
            return staticDataExpertMode[staticDataOrder[qn]]
        case .none:
            return ([], .none, [], -1)
        }
    }
    
    static func makeRandomColorValue() -> QuizData {
        let ans = Int(arc4random() % 10)
        var choices = Array<Int>(0...9)
            .filter({$0 != ans})
            .shuffled().prefix(3)
        choices.append(ans)
        choices.shuffle()
        let ansIndex = Int(choices.firstIndex(of: ans)!)
        return ([ans], .value, choices.map({String($0)}), ansIndex)
    }
    static func makeRandomColorScale() -> QuizData {
        let ans = Int(arc4random() % 10)
        var choices = Array<Int>(0...9)
            .filter({$0 != ans})
            .shuffled().prefix(3)
        choices.append(ans)
        choices.shuffle()
        let ansIndex = Int(choices.firstIndex(of: ans)!)
        return (
            [ans > 7 ? ans + 2 : ans], .scale,
            choices.map({"10^\(rRingScales[($0 > 7 ? $0 + 2 : $0)])"}), ansIndex
        )
    }
    
    static func makeRandomColorTolerance() -> QuizData {
        let posibilities: [Int] = [0, 1, 4, 5, 6, 7, 10, 11]
        let ans = posibilities[Int(arc4random() % 8)]
        var choices = posibilities
            .filter({$0 != ans})
            .shuffled().prefix(3)
        choices.append(ans)
        choices.shuffle()
        let ansIndex = Int(choices.firstIndex(of: ans)!)
        return ([ans], .tolerance, choices.map({"\(rRingErrors[$0])%"}), ansIndex)
    }
    
    static let staticData3Band: [([Int], [String], Int)] = [
        ([1,0,10], ["1Ω", "10Ω", "100Ω", "1k"], 0),
        ([1,0,3], ["100Ω", "1k", "10k", "0.1M"], 2),
        ([1,2,1], ["12Ω", "120Ω", "12k", "120k"], 1),
        ([1,2,3], ["200Ω", "22k", "12k", "2M"], 2),
        ([1,8,5], ["1.8M", "1M", "18M", "10M"], 0),
        ([4,7,10], ["4.7Ω", "47Ω", "470Ω", "4.7k"], 0),
        ([1,8,3], ["18Ω", "180Ω", "1.8K", "18K"], 3),
        ([2,2,0], ["20Ω", "22Ω", "24Ω", "33Ω"], 1),
        ([2,2,1], ["2.2k", "3.3k", "330Ω", "220Ω"], 3),
        ([3,0,10], ["2Ω", "3Ω", "5.1Ω", "10Ω"], 1),
        ([3,0,6], ["30k", "300k", "3M", "30M"], 3),
        ([4,7,3], ["4.7k", "47k", "6.8k", "68k"], 1),
        ([4,7,6], ["47k", "68k", "47M", "68M"], 2),
        ([6,8,1], ["6.8k", "4.7k", "680Ω", "470Ω"], 2),
        ([6,8,10], ["6.8Ω", "68Ω", "680Ω", "6.8k"], 0),
        ([6,8,4], ["51k", "680k", "5.1M", "6.8k"], 1),
        ([5,1,2], ["51k", "51Ω", "510Ω", "5.1k"], 3),
        ([5,1,5], ["510Ω", "5.1k", "510k", "5.1M"], 3),
        ([2,4,0], ["48Ω", "24Ω", "12Ω", "12k"], 1),
        ([2,4,2], ["12k", "12M", "2.4k", "240Ω"], 2),
        ([7,5,10], ["7.5Ω", "75Ω", "750Ω", "7.5k"], 0),
        ([7,5,1], ["7.5Ω", "75Ω", "750Ω", "7.5k"], 2),
        ([3,6,2], ["3.6k", "240Ω", "3.6M", "240k"], 0),
        ([3,6,0], ["24Ω", "36Ω", "47k", "51k"], 1),
        ([3,3,1], ["3.3M", "2.2M", "330", "220"], 2),
        ([3,3,4], ["51k", "110k", "330k", "360k"], 2),
        ([2,0,5], ["20Ω", "2Ω", "2k", "2M"], 3),
        ([1,5,4], ["75M", "15M", "750k", "150k"], 3),
        ([1,5,0], ["15Ω", "36Ω", "47Ω", "51Ω"], 0),
        ([3,0,10], ["3Ω", "2Ω", "3k", "2k"], 0),
    ]
    
    static let staticDataExpertMode: [QuizData] = [
        ([2,4,2,5], .value, ["1k2","1M2","2k4","2M4"], 2),//2.4k
        ([4,8,0,1,11], .value, ["470R","4k7","480R","4k8"], 3),//4.8k
        ([1,2,3,4], .value, ["12R","12k","120k","12M"], 1),//12k
        ([3,6,0,11,10], .value, ["3R6","36R","48R","480R"], 0),//3.6
        ([3,6,4,6], .value, ["120k","240k","360k","480k"], 2),//360k
        ([3,6,0,5,7], .value, ["3.6R","36R","36k","36M"], 3),//36M
        ([4,7,10,10], .value, ["4R7","4k7","4k8","4M8"], 0),//4.7
        ([4,7,0,2,1], .value, ["24k","47k","51k","68k"], 1),//47k
        ([4,7,5,5], .value, ["47k","68k","4M7","6M8"], 2),//4.7M
        ([5,1,10,1], .value, ["5M1","51k","510R","5R1"], 3),//5.1
        ([5,1,0,11], .value, ["51R","5K1","68R","6k8"], 0),//51
        ([5,1,0,2,4], .value, ["68k","48k","51k","47k"], 2),//51k
        ([6,8,0,0], .value, ["6R8","68R","4k7","47R"], 1),//68
        ([6,8,0,0,4], .value, ["51R","51K","68R","680R"], 3),//680
        ([6,8,3,0], .value, ["480R","5k1","6k8","68R"], 2),//6.8k
        
        ([1,0,3,5], .tolerance, ["±25R","±2R5","±40R","±4R"], 0),//10k 0.25
        ([1,0,0,2,4], .tolerance, ["±500R","±50R","±2k","±20R"], 1),//10k 0.5
        ([4,7,2,0], .tolerance, ["±470m","±4.7R","±47R","±470R"], 2),//4k7 1
        ([4,7,0,2,6], .tolerance, ["±3R6","±36R","±4R7","±47R"], 3),//47k 0.1
        ([5,1,1,0], .tolerance, ["±5R1","±51R","±510R","±5k1"], 0),//510 1
        ([5,1,3,11], .tolerance, ["±51k","±5k1","±510R","±51R"], 1),//51k 10
        ([2,2,4,10], .tolerance, ["±44k","±440R","±11k","±110R"], 2),//220k 5
        ([3,6,1,10], .tolerance, ["±720R","±72R","±180R","±18R"], 3),//360 5
        ([1,0,0,3,7], .tolerance, ["±50R","±500R","±5k","±50k"], 0),//100k 0.05
        ([3,3,3,1], .tolerance, ["±66R","±660R","±165R","±1k65"], 1),//33k 2
        ([6,8,0,3,6], .tolerance, ["±68k","±6k8","±680R","±68R"], 2),//680k 0.1
        ([2,0,3,4], .tolerance, ["±4k","±400R","±1k","±100R"], 3),//20k 0.5
        ([1,1,1,1], .tolerance, ["±22R","±2R2","±55R","±5R5"], 1),//110 2
        ([2,0,5,5], .tolerance, ["±500k","±50k","±80k","±8k"], 0),//2M 0.25
        ([4,8,0,1,7], .tolerance, ["±96R","±24R","±960R","±240R"], 3),//4k8 0.05
    ]
}

var staticDataOrder: [Int] = Array(0...29).shuffled()
