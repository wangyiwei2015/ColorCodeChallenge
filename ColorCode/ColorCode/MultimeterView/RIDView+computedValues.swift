//
//  File.swift
//  
//
//  Created by wyw on 2022/4/20.
//

import SwiftUI

extension RIDView {
    //computed ring meter values
    var ringValue: Double {
        let firstIndex = ringColorIndex.firstIndex(where: {$0 > 9}) ?? 9
        if firstIndex < max(ringColorIndex.count - 2, 2) {return 0.0}
        //above is invalid case
        switch ringColorIndex.count {
        case 3, 4:
            let rc10 = Double(ringColorIndex[0]) * 10
            let rcv = Double(ringColorIndex[1]) + rc10
            let pw = Double(rRingScales[ringColorIndex[2]])
            return rcv * pow(10.0, pw)
        case 5:
            let rc100 = Double(ringColorIndex[0]) * 100
            let rc10 = Double(ringColorIndex[1]) * 10
            let rcv = Double(ringColorIndex[2]) + rc10 + rc100
            let pw = Double(rRingScales[ringColorIndex[3]])
            return rcv * pow(10.0, pw)
        default:
            return 0.0
        }
    }
    var ringError: Int {
        if ringColorIndex.count > 3 {
            return ringColorIndex.last!
        } else if ringColorIndex.count == 3 {
            return 12
        } else {return 2}
    }
}

extension RIDView {
    //computed smt meter value
    var smtValue: Double {
        if smtSilk.count < 3 {return 0.0}
        if smtSilk.firstIndex(of: "R") != nil {
            return Double(smtSilk.replacingOccurrences(of: "R", with: ".")) ?? 0.0
        }
        if let pureNumber = Double(smtSilk) {
            let pureInt = Int(pureNumber)
            let lastDigit = pureInt % 10
            let number = Double(smtSilk.dropLast()) ?? 0.0
            return number * pow(10.0, Double(lastDigit))
        } else {
            //deal with XABCDE
            let lastChar = String(smtSilk.last!)
            guard let number = Int(smtSilk.dropLast()) else {
                return 0.0
            }
            guard number > 0 && number < 97 else {
                return 0.0
            }
            guard let rScale = rTabelScale[lastChar] else {
                return 0.0
            }
            return Double(rTable[number]) * rScale
        }
    }
    var smtError: Int {
        if smtSilk.count == 4 {return 0}
        if smtSilk.count == 3 {
            if smtSilk.firstIndex(of: "R") != nil {
                return 0
            } else {
                if Int(String(smtSilk.last!)) == nil {
                    return 2
                } else {
                    return 10
                }
            }
        }
        return 2
        // 4 digit or contain R than 1% id 0
        // 3 digit and no R 5% id 10
        // ? id 2
    }
}
