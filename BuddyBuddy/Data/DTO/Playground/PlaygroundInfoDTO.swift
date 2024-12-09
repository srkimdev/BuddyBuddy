//
//  PlaygroundInfoDTO.swift
//  BuddyBuddy
//
//  Created by 아라 on 12/4/24.
//

import Foundation

struct PlaygroundInfoDTO: Decodable {
    let playgroundID, name: String
    let description, coverImage: String?
    let ownerID, createdAt: String

    enum CodingKeys: String, CodingKey {
        case playgroundID = "workspace_id"
        case name, description, coverImage
        case ownerID = "owner_id"
        case createdAt
    }
}

extension PlaygroundInfoDTO {
    func toDomain() -> Playground {
        return Playground(
            playgroundID: playgroundID,
            name: name,
            description: description,
            coverImage: coverImage,
            ownerID: ownerID,
            createdAt: createdAt
        )
    }
}
