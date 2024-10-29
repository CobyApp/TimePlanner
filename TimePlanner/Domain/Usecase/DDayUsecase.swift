//
//  DDayUsecase.swift
//  TimePlanner
//
//  Created by Coby on 10/22/24.
//

import Foundation

protocol DDayUsecase {
    func createDDay(dDay: DDayModel) async throws
    func updateDDay(dDay: DDayModel) async throws
    func deleteDDay(dDayId: String) async throws
    func getDDays() async throws -> [DDayModel]
    func getDDaysForDate(_ date: Date) async throws -> [DDayModel]
}

final class DDayUsecaseImpl: DDayUsecase {
       
    // MARK: - property
    
    private let repository: DDayRepository
    
    // MARK: - init
    
    init(repository: DDayRepository) {
        self.repository = repository
    }
    
    // MARK: - Public - func
    
    func createDDay(dDay: DDayModel) async throws {
        do {
            try await self.repository.createDDay(dDay: dDay)
        } catch(let error) {
            throw error
        }
    }
    
    func updateDDay(dDay: DDayModel) async throws {
        do {
            try await self.repository.updateDDay(dDay: dDay)
        } catch(let error) {
            throw error
        }
    }
    
    func deleteDDay(dDayId: String) async throws {
        do {
            try await self.repository.deleteDDay(dDayId: dDayId)
        } catch(let error) {
            throw error
        }
    }
    
    func getDDays() async throws -> [DDayModel] {
        do {
            let dDays = try await self.repository.getDDays().map { $0.toDDayModel() }
            return dDays
        } catch(let error) {
            throw error
        }
    }
    
    func getDDaysForDate(_ date: Date) async throws -> [DDayModel] {
        do {
            let dDays = try await self.repository.getDDaysForDate(date).map { $0.toDDayModel() }
            return dDays
        } catch(let error) {
            throw error
        }
    }
}
