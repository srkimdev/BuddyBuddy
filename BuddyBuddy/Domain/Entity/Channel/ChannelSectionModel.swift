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
    case channel(MyChannel)
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

enum Accordion: String {
    case arrow = "chevronRight"
    case caret = "chevronDown"
}
