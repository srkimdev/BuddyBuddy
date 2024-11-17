//
//  ChannelSectionModel.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/13/24.
//

import Foundation

import RxDataSources

enum ChannelSectionModel: Equatable {
    case title(item: ChannelItem)
    case list(items: [ChannelItem])
    case add(items: [ChannelItem])
}

enum ChannelItem: Equatable {
    case title(Accordion)
    case channel(Channel)
    case add(String)
    
    static func == (
        lhs: ChannelItem,
        rhs: ChannelItem
    ) -> Bool {
        return false
    }
}

extension ChannelSectionModel: SectionModelType {
    typealias Item = ChannelItem
    
    var items: [ChannelItem] {
        switch self {
        case .title(let item):
            return [item]
        case .list(let items):
            return items.map { $0 }
        case .add(let items):
            return items.map { $0 }
        }
    }
    
    init(
        original: ChannelSectionModel,
        items: [ChannelItem]
    ) {
        self = original
    }
}

struct Channel {
    let title: String
    let image: String = "number"
    let isRead: Bool
}

enum Accordion: String {
    case arrow = "chevronRight"
    case caret = "chevronDown"
}
