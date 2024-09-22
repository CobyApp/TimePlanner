//
//  String+DateFormatter.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import Foundation

extension String {
    /// String 값을 yy.MM.dd 형식의 Date 값으로 변환
    var toDefaultDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.date(from: self)
    }
    
    /// String 값을 yyyy.MM.dd 형식의 Date 값으로 변환
    var toFullDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.date(from: self)
    }
}
