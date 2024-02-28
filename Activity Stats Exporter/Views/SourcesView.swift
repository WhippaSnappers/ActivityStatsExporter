//
//  SourcesView.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 16.02.2024.
//

import SwiftUI
import HealthKit

struct SourcesView: View {
    @State private var model: SourcesModel
    @State var sourceSelected: HKSource? = nil
    private let datesPicked: [Date]
    
    var body: some View {
        VStack {
            if model.isAwaiting {
                ProgressView().progressViewStyle(.circular)
            }
            if model.noStepsData && !model.isAwaiting {
                Text("No steps data for selected dates")
            }
            if !model.isAwaiting && !model.noStepsData {
                Text("Select the source for steps")
                Picker("", selection: $sourceSelected) {
                    ForEach(Array(model.sources).sorted { $0.name < $1.name }, id: \.self) { source in
                        Text(source.name)
                    }
                }.pickerStyle(.wheel)
                NavigationLink(destination: StepsView(datesPicked)) {
                    Text("Fetch steps")
                }.buttonStyle(.borderedProminent)
            }
        }.task {
            await model.populateSources()
        }
    }
    
    init(_ datesPicked: [Date]) {
        self.datesPicked = datesPicked
        model = SourcesModel(datesPicked)
    }
}

#Preview {
    SourcesView([])
}
