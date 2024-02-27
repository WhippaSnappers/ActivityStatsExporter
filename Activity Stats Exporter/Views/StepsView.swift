//
//  StepsView.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 07.02.2024.
//

import SwiftUI

struct StepsView: View {
    @State private var stepsModel: StepsModel
    
    var body: some View {
        VStack {
            
            List(stepsModel.stepsSamples) { stepsSample in
                Text(stepsSample.toText())
            }.task {
                do {
                    try await stepsModel.populateStepsSamples()
                } catch {
                    
                }
            }
            
        }
    }
    
    init(datesPicked: Set<DateComponents>) {
        self.stepsModel = StepsModel(using: datesPicked)
    }
}

#Preview {
    StepsView(datesPicked: [])
}
