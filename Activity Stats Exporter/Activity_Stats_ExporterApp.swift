//
//  Activity_Stats_ExporterApp.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 05.02.2024.
//

import SwiftUI
import SwiftData

@main
struct Activity_Stats_ExporterApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
