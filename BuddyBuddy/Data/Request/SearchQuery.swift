//
//  SearchQuery.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/19/24.
//

import Foundation

struct SearchQuery: Encodable {
    let playgroundID: String
    let keyword: String
    
    enum CodingKeys: String, CodingKey {
        case playgroundID = "workspace_id"
        case keyword
    }
}
