//
//  DDayDTO.swift
//  TimePlanner
//
//  Created by Coby on 10/22/24.
//

import FirebaseFirestore

struct DDayDTO: Identifiable, Hashable, Equatable {
    
    @DocumentID var id: String?

    let name: String
    let dDate: Date
}
