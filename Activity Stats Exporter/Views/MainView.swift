//
//  MainView.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 06.02.2024.
//

import SwiftUI

struct MainView: View {
    @State private var datesPicked: Set<DateComponents> = []
    let dateRangeToToday = ..<Date()
    
    var body: some View {
        NavigationStack {
            Text("Pick the dates").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            MultiDatePicker(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/, selection: $datesPicked, in: dateRangeToToday)
            NavigationLink(destination: SourcesView()) {
                Text("WIP")
            }.buttonStyle(.borderedProminent).disabled(true)
            NavigationLink(destination: StepsView(datesPicked: datesPicked)) {
                Text("Fetch steps")
            }.buttonStyle(.borderedProminent).disabled(datesPicked.isEmpty)
            Button("Reset calendar") {
            action: do { datesPicked.removeAll() }
            }.buttonStyle(.borderedProminent).tint(.red)
        }
    }
}

#Preview {
    MainView()
}
