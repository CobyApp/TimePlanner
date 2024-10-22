//
//  DDayRepository.swift
//  TimePlanner
//
//  Created by Coby on 10/22/24.
//

import Foundation

protocol DDayRepository {
    func createDDay(dDay: DDayModel) async throws
    func updateDDay(dDay: DDayModel) async throws
    func deleteDDay(dDayId: String) async throws
    func getDDays() async throws -> [DDayDTO]
}
