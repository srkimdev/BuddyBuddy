//
//  ChannelSectionModel.swift
//  BuddyBuddy
//
//  Created by 아라 on 11/13/24.
//

import Foundation

import RxDataSources

struct ChannelListSectionModel {
    var items: [Item]
}

extension ChannelListSectionModel: SectionModelType {
    typealias Item = Channel
    
    init(original: ChannelListSectionModel, items: [Channel]) {
        self = original
        self.items = items
    }
}

struct Channel {
    let title: String
}


struct ChannelTitleSectionModel {
    var items: [Item]
}

extension ChannelTitleSectionModel: SectionModelType {
    typealias Item = Accordion
    
    init(original: ChannelTitleSectionModel, items: [Accordion]) {
        self = original
        self.items = items
    }
}

enum Accordion: String {
    case arrow = "chevronRight"
    case caret = "chevronDown"
}

struct AddChannelSectionModel {
    var items: [Item]
}

extension AddChannelSectionModel: SectionModelType {
    typealias Item = AddChannel
    
    init(original: AddChannelSectionModel, items: [AddChannel]) {
        self = original
        self.items = items
    }
}

struct AddChannel {
    let title = "채널추가"
    let imageString = "plus"
}
