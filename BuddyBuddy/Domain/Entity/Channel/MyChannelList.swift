//
//  MyChannelList.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/19/24.
//

import Foundation

typealias MyChannelList = [MyChannel]

struct MyChannel {
    let workspaceID: String
    let name: String
    let description: String?
    let coverImage: String
    let ownerID: String
    let createdAt: String
}
