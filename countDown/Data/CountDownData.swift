//
//  CountDownData.swift
//  countDown
//
//  Created by 林華淵 on 2022/3/26.
//

import Foundation

struct CountDownData{
    var projectName: String
    var targetDate: Date
    
    func returnNums() -> (String,String,String){
        
        let interval = Int(targetDate.timeIntervalSinceNow)
        if interval <= 0 {
            return("000","00","00")
        }
        
        let hr = interval / (60 * 60)
        let min = interval / 60 % 60
        let sec = interval % 60
        
        let numberFormatter = NumberFormatter()
        numberFormatter.paddingCharacter = "0" //不足補0
        numberFormatter.formatWidth = 2
        
        let minStr = numberFormatter.string(from: NSNumber(value: min)) ?? "00"
        let secStr = numberFormatter.string(from: NSNumber(value: sec)) ?? "00"
        
        numberFormatter.formatWidth = 3
        let hrStr = numberFormatter.string(from: NSNumber(value: hr)) ?? "000"
        
        return (hrStr,minStr,secStr)
    }
}
