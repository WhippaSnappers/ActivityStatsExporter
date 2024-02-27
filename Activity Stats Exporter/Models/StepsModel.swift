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
    private let errorHandler = ErrorHandler()
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

struct test {
    static func query(_ store: HKHealthStore) async {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let timePredicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: [])
        let stepsType = HKQuantityType(.stepCount)
        let samplePredicate = HKSamplePredicate.quantitySample(type: stepsType, predicate: timePredicate)
        let sourceQuery = HKSourceQueryDescriptor(predicate: samplePredicate)
    
        //let query1 = HKStatisticsQueryDescriptor(predicate: samplePredicate, options: .cumulativeSum)
        
        
        do {
            var result = try await sourceQuery.result(for: store)
            print("good")
        }
        catch {
            print("fuck")
        }
    }
                    
}
