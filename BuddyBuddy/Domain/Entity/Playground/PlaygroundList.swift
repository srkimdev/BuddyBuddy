//
//  PlaygroundList.swift
//  BuddyBuddy
//
//  Created by 아라 on 12/1/24.
//

import Foundation

typealias PlaygroundList = [Workspace]

struct Workspace {
    let workspaceID, name: String
    let description, coverImage: String?
    let ownerID, createdAt: String
}
