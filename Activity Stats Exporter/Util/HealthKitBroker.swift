//
//  HealthKitBroker.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 27.02.2024.
//

import Foundation
import HealthKit

// Helps to communicate with the HealthKit framework
class HealthKitBroker {
    let healthStore: HKHealthStore = HKHealthStore()
    let requiredTypes: Set = [
        HKQuantityType(.stepCount)
    ]
    
    func requestAuthorisation() async throws {
        if HKHealthStore.isHealthDataAvailable() {
            do {
                try await healthStore.requestAuthorization(toShare: Set<HKQuantityType>(), read: requiredTypes)
            } catch {
                throw ErrorDescriptor(severity: .critical, message: "HealthKit authorisation failed")
            }
        } else {
            throw ErrorDescriptor(severity: .critical, message: "HealthKit unavailable on this device")
        }
    }
}
