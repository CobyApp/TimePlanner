//
//  DDayModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

struct DDayModel: Identifiable, Hashable, Equatable {
    
    var id: UUID
    var name: String
    var dDate: Date
    
    init(
        id: UUID = UUID(),
        name: String = "",
        dDate: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.dDate = dDate
    }
}
