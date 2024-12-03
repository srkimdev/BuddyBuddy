//
//  NetworkError.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 12/4/24.
//

import Foundation

enum NetworkError: Error, Equatable {
    case E03, E06
    case unknown(message: String)

    init(_ error: String) {
        switch error {
        case "E03":
            self = .E03
        case "E06":
            self = .E06
        default:
            self = .unknown(message: error)
        }
    }
}
