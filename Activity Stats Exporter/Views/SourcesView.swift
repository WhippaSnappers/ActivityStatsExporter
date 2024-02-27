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
    @State private var isAwaiting: Bool = false // Change to true
    @State private var noStepsData: Bool = false
    private let datesPicked: [Date]
    
    var body: some View {
        VStack {
            if isAwaiting {
                ProgressView().progressViewStyle(.circular)
            }
            if noStepsData {
                Text("No steps data for selected dates")
            }
            if !isAwaiting && !noStepsData {
                Text("Select the source for steps")
                Picker("", selection: $sourceSelected) {
                    ForEach(model.sources, id: \.self) { source in
                        Text(source.name)
                    }
                }.pickerStyle(.wheel)
                NavigationLink(destination: StepsView(datesPicked)) {
                    Text("Fetch steps")
                }.buttonStyle(.borderedProminent)
            }
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
