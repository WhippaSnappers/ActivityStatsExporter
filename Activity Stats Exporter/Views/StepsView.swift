//
//  StepsView.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 07.02.2024.
//

import SwiftUI
import HealthKit

struct StepsView: View {
    @State private var stepsModel: StepsModel
    
    var body: some View {
        VStack {
            List(stepsModel.stepsSamplesSorted, id: \.self) { stepsSample in
                Text(stepsSample.toText())
            }.task {
                await stepsModel.populateStepsSamples()
            }
        }
    }
    
    init(datesPicked: [Date]?, source: HKSource?) {
        self.stepsModel = StepsModel(datesPicked: datesPicked!, source: source!)
    }
}

#Preview {
    StepsView(datesPicked: nil, source: nil)
}
