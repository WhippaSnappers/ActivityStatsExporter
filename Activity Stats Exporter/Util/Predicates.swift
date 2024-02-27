//
//  Predicates.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 27.02.2024.
//

import Foundation
import HealthKit

// Assembles the required predicate for the HKStatisticsQuery
struct HealthKitStepsPredicate {
    private let stepsType = HKQuantityType(.stepCount)
    private let predicateStartDate: Date
    private let predicateEndDate: Date
    
    private var dayPredicate: NSPredicate {
        get {
            return HKQuery.predicateForSamples(withStart: predicateStartDate, end: predicateEndDate)
        }
    }
    
    var get: HKSamplePredicate<HKQuantitySample> {
        get {
            return HKSamplePredicate.quantitySample(type: stepsType, predicate: dayPredicate)
        }
    }
    
    init(start startDate: Date, end endDate: Date) {
        self.predicateStartDate = startDate
        self.predicateEndDate = endDate
    }
}
