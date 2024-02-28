//
//  ErrorHandler.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 27.02.2024.
//

import Foundation
import OSLog

// Handles custom Errors
enum ErrorHandler {
    static func handle(_ error: ErrorDescriptor) {
        let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Execution flow")
        switch error.severity {
        case .warning:
            logger.log("\(error.message)")
        case .critical:
            logger.log("\(error.message)")
            fatalError()
        }
    }
    
    static func handle(_ error: Error) {
        let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Execution flow")
        logger.log("\(error.localizedDescription)")
        fatalError()
    }
}

// Custom Error class
struct ErrorDescriptor : Error {
    let severity: Severity
    let message: String
    
    enum Severity {
        case warning
        case critical
    }
}
