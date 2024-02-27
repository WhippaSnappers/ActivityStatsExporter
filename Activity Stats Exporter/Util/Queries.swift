//
//  Queries.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 27.02.2024.
//

import Foundation
import HealthKit

struct Querier {
    static func craftHKStepsQuery(using predicate: HKSamplePredicate<HKQuantitySample>) -> HKStatisticsQueryDescriptor {
        return HKStatisticsQueryDescriptor(predicate: predicate, options: .cumulativeSum)
    }
    
    static func execute(this query: HKStatisticsQueryDescriptor, against store: HKHealthStore) async throws -> Double {
        do {
            let result = try await query.result(for: store)?.sumQuantity()?.doubleValue(for: HKUnit.count())
            return result!
        } catch {
            throw ErrorDescriptor(severity: .critical, message: "HealthKit StatisticsQuery execution failed")
        }
    }
    
    static func execute(this query: HKSourceQueryDescriptor<HKQuantitySample>, against store: HKHealthStore) async throws -> [HKSource] {
        do {
            let result = try await query.result(for: store)
            return result
        } catch {
            throw ErrorDescriptor(severity: .critical, message: "HealthKit SourceQuery execution failed")
        }
    }
}
