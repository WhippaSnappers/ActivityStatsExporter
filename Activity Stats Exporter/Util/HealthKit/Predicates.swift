//
//  Predicates.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 27.02.2024.
//

import Foundation
import HealthKit

enum PredicateCrafter {
    static func craftSimpleHKStepsPredicate(start startDate: Date, end endDate: Date) -> HKSamplePredicate<HKQuantitySample> {
        let rangePredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        return HKSamplePredicate.quantitySample(type: HKQuantityType(.stepCount), predicate: rangePredicate)
    }
    
    static func craftCompoundHKStepsPredicate(start startDate: Date, end endDate: Date, from source: HKSource) -> HKSamplePredicate<HKQuantitySample> {
        let rangePredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let sourcePredicate = HKQuery.predicateForObjects(from: source)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [rangePredicate, sourcePredicate])
        return HKSamplePredicate.quantitySample(type: HKQuantityType(.stepCount), predicate: compoundPredicate)
    }
}
