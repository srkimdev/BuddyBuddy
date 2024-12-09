//
//  PlaygrondListResponseDTO.swift
//  BuddyBuddy
//
//  Created by 아라 on 12/1/24.
//

import Foundation

typealias PlaygroundListResponseDTO = [PlaygrondDTO]

struct PlaygrondDTO: Decodable {
    let workspaceID, name: String
    let description, coverImage: String?
    let ownerID, createdAt: String

    enum CodingKeys: String, CodingKey {
        case workspaceID = "workspace_id"
        case name, description, coverImage
        case ownerID = "owner_id"
        case createdAt
    }
}

extension PlaygrondDTO {
    func toDomain() -> Workspace {
        return Workspace(
            workspaceID: workspaceID,
            name: name,
            description: description,
            coverImage: coverImage,
            ownerID: ownerID,
            createdAt: createdAt
        )
    }
}
