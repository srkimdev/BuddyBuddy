//
//  ChangeChannelQuery.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/29/24.
//

import Foundation

struct ChangeChannelQuery: Encodable {
    let ownerID: String
    
    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
    }
}
