//
//  StepsModel.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 10.02.2024.
//

import Foundation
import HealthKit
import os

// Main VM
@Observable final class StepsModel {
    private let dates: [Date]
    private let source: HKSource
    private var healthKitAvailableAndAuthorised: Bool = false
    private var stepsSamples: [StepsSample] = []
    var stepsSamplesSorted: [StepsSample] { stepsSamples.sorted { $0.date < $1.date } }
    
    init(datesPicked: [Date], source: HKSource) {
        dates = datesPicked
        self.source = source
    }
    
    func populateStepsSamples() async {
        for date in dates {
            var steps = await queryForSteps(on: date)
            stepsSamples.append(StepsSample(date: date, count: Int(steps)))
        }
    }
    
    private func queryForSteps(on date: Date) async -> Double {
        let predicate = PredicateCrafter.craftCompoundHKStepsPredicate(start: DateConverter.start(of: date), end: DateConverter.end(of: date), from: source)
        let query = QueryCrafter.craftHKStepsQuery(using: predicate)
        do {
            return try await QueryExecutor.execute(this: query, against: HKHealthStore())
        } catch {
            ErrorHandler.handle(error)
            return -1
        }
    }
}

// Models a StepSample that SwiftUI renders within a List
struct StepsSample : Hashable {
    let date: Date
    let count: Int
    
    func toText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return "\(dateFormatter.string(from: date)) \(String(count))"
    }
}
