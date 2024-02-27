//
//  ErrorHandler.swift
//  Activity Stats Exporter
//
//  Created by Paul Cherevach on 27.02.2024.
//

import Foundation
import OSLog

// Handles custom Errors
struct ErrorHandler {
    let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "Execution flow")
    
    func handle(_ error: ErrorDescriptor) {
        switch error.severity {
        case .warning:
            logger.log("\(error.message)")
        case .critical:
            logger.log("\(error.message)")
            fatalError()
        }
    }
    
    func handle(_ error: Error) {
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
