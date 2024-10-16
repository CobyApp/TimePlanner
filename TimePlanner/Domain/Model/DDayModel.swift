//
//  DDayModel.swift
//  TimePlanner
//
//  Created by Coby on 10/14/24.
//

import Foundation

struct DDayModel: Identifiable, Hashable, Equatable {
    
    let id: String
    let name: String
    let dDate: Date
    
    init(
        id: String = UUID().uuidString,
        name: String = "",
        dDate: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.dDate = dDate
    }
}
