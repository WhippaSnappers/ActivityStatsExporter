//
//  DateConverter.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 27.02.2024.
//

import Foundation

// Helps to extract start and end points from a Day
enum DateConverter {
    static func start(of date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }

    static func end(of date: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: start(of: date))!
    }
    
    static func extractDates(from dateComponents: Set<DateComponents>) -> [Date] {
        var extractedDates: [Date] = []
        for dateComponent in dateComponents {
            extractedDates.append(dateComponent.date!)
        }
        return extractedDates
    }
}
