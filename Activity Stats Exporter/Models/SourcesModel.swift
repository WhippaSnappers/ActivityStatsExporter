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
    var sources: [HKSource] = []
    
    init(_ datesPicked: [Date]) {
        self.datesPicked = datesPicked
    }
    
    private func populateSources() {
        
    }
}
