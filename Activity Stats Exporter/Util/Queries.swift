//
//  Queries.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 27.02.2024.
//

import Foundation
import HealthKit

// Uses HKStatisticsQuery to query HealthKit store for steps
struct HealthKitStepsQuery {
    private let predicate: HKSamplePredicate<HKQuantitySample>
    private let query: HKStatisticsQueryDescriptor
    
    init(using predicate: HKSamplePredicate<HKQuantitySample>) {
        self.predicate = predicate
        query = HKStatisticsQueryDescriptor(predicate: predicate, options: .cumulativeSum)
    }
    
    func execute(using broker: HealthKitBroker) async throws -> Double {
        do {
            let test = try await query.result(for: broker.healthStore)
            let result = try await query.result(for: broker.healthStore)?.sumQuantity()?.doubleValue(for: HKUnit.count())
            return result!
        } catch {
            throw ErrorDescriptor(severity: .critical, message: "HealthKit StatisticsQuery execution failed")
        }
    }
}

struct HealthKitSourcesQuery {
    
}
