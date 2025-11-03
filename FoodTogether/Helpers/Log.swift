//
//  Log.swift
//  FoodTogether
//
//  Created by Alaina Ge on 2025-10-26.
//

import os

struct Log {
    static let shared = Logger(subsystem: "com.yourapp", category: "network")

    static func info(_ message: String) {
        shared.info("\(message, privacy: .public)")
    }

    static func error(_ message: String) {
        shared.error("\(message, privacy: .public)")
    }
}
