//
//  Date+Extension.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import Foundation

extension Date {

    /// Date 값을 yy.MM.dd 형식의 String 값으로 변환
    var toDefaultString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
    
    /// Date 값을 yyyy.MM.dd 형식의 String 값으로 변환
    var toFullString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
    
    var dDay: String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let targetDate = calendar.startOfDay(for: self)
        let components = calendar.dateComponents([.day], from: today, to: targetDate)

        guard let dayDifference = components.day else { return "D - Day" }

        if dayDifference == 0 {
            return "D - Day"
        } else if dayDifference > 0 {
            return "D - \(dayDifference)"
        } else {
            return "D + \(-dayDifference)"
        }
    }
}
