//
//  MainView.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 06.02.2024.
//

import SwiftUI
import HealthKit

struct MainView: View {
    @State private var datesPicked: Set<DateComponents> = []
    @State private var alertShown: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("Pick the dates").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            MultiDatePicker("", selection: $datesPicked, in: ..<Date())
            NavigationLink(destination: SourcesView(DateConverter.extractDates(from: datesPicked))) {
                Text("Fetch steps")
            }.buttonStyle(.borderedProminent).disabled(datesPicked.isEmpty)
            Button("Reset calendar") {
            action: do { datesPicked.removeAll() }
            }.buttonStyle(.borderedProminent).tint(.red)
        }.task {
            do {
                try await HKBroker.requestAuthorisation(for: HKHealthStore())
            } catch {
                alertShown = true
            }
        }.alert("HealthKit authorisation failed", isPresented: $alertShown) { }
    }
}

#Preview {
    MainView()
}
