//
//  Predicates.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 27.02.2024.
//

import Foundation
import HealthKit

struct Predicator {
    static func craftHKStepsPredicate(start startDate: Date, end endDate: Date) -> HKSamplePredicate<HKQuantitySample> {
        let stepsType = HKQuantityType(.stepCount)
        let dayPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        return HKSamplePredicate.quantitySample(type: stepsType, predicate: dayPredicate)
    }
}
