//
//  SourcesModel.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 26.02.2024.
//

import Foundation
import HealthKit

@Observable class SourcesModel {
    private let datesPicked: [Date]
    private var sources: Set<HKSource> = Set<HKSource>()
    var sourcesSorted: [HKSource] { Array(sources).sorted { $0.name < $1.name } }
    var isAwaiting: Bool = true
    var noStepsData: Bool = false
    
    init(_ datesPicked: [Date]) {
        self.datesPicked = datesPicked
        print("SPAWNED")
    }
    
    func populateSources() async {
        for date in datesPicked {
            let dateSources = await queryForSources(on: date)
            sources.formUnion(dateSources)
        }
        isAwaiting = false
        noStepsData = sources.isEmpty
    }
    
    private func queryForSources(on date: Date) async -> [HKSource] {
        let datePredicate = PredicateCrafter.craftSimpleHKStepsPredicate(start: DateConverter.start(of: date), end: DateConverter.end(of: date))
        let query = QueryCrafter.craftHKSourcesQuery(using: datePredicate)
        do {
            return try await QueryExecutor.execute(this: query, against: HKHealthStore())
        } catch {
            ErrorHandler.handle(error)
            return []
        }
    }
}
