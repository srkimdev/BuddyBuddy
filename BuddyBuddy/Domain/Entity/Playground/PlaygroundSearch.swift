//
//  PlaygroundSearch.swift
//  BuddyBuddy
//
//  Created by Jisoo Ham on 11/20/24.
//

import Foundation

struct PlaygroundSearch {
    let playgroundID: String
    let playgroundName: String
    let description: String?
    let coverImage: String
    let ownerID: String
    let createdAt: String
    let channels: [PlaygroundChannel]
    let playgroundMembers: [PlaygroundMember]
}

struct PlaygroundChannel {
    let channelID: String
    let channelName: String
    let coverImage: String?
    let ownerID: String
    let createdAt: String
}

struct PlaygroundMember {
    let userID: String
    let email: String
    let nickname: String
    let profileImage: String?
}
