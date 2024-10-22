//
//  DDayMapper.swift
//  TimePlanner
//
//  Created by Coby on 10/22/24.
//

import Foundation

extension DDayDTO {
    
    func toDDayModel() -> DDayModel {
        DDayModel(
            id: self.id ?? UUID().uuidString,
            name: self.name,
            dDate: self.dDate
        )
    }
}
