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
    private var healthKitAvailableAndAuthorised: Bool = false
    var stepsSamples: [StepsSample] = []
    
    init(_ dates: [Date]) {
        self.dates = dates
    }
    
    func populateStepsSamples() async throws {
        var id = 0
        for date in dates {
//            await test.query(healthKitBroker.healthStore)
//            let start = DateConverter.start(of: date.date!)
//            let end = DateConverter.end(of: date.date!)
//            let stepsPredicate = HealthKitStepsPredicate(start: start, end: end)
//            let stepsQuery = HealthKitStepsQuery(using: stepsPredicate.get)
//            let stepsCount: Double?
//            do {
//                stepsCount = try await stepsQuery.execute(using: healthKitBroker)
//                stepsSamples.append(StepsSample(id: id, date: date.date!, count: Int(stepsCount!)))
//                id += 1
//            } catch let error as ErrorDescriptor {
//                errorHandler.handle(error)
//            }
        }
    }
}

struct HealthKitSourcesPredicate {
    
}

struct HealhKitSourcesQuery {
    
}

// Models a StepSample that SwiftUI renders within a List
struct StepsSample : Identifiable {
    let id: Int
    let date: Date
    let count: Int
    
    func toText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date) + " " + String(count)
    }
}
