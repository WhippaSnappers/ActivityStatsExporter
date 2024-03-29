//
//  HKBroker.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 27.02.2024.
//

import Foundation
import HealthKit

// Helps to communicate with the HealthKit framework
enum HKBroker {
    static func requestAuthorisation(for store: HKHealthStore) async throws {
        if HKHealthStore.isHealthDataAvailable() {
            do {
                try await store.requestAuthorization(toShare: Set<HKQuantityType>(), read: Set<HKQuantityType>([HKQuantityType(.stepCount)]))
            } catch {
                throw ErrorDescriptor(severity: .critical, message: "HealthKit authorisation failed")
            }
        } else {
            throw ErrorDescriptor(severity: .critical, message: "HealthKit unavailable on this device")
        }
    }
}
