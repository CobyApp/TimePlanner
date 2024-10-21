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
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
}
