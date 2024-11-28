//
//  ChatSection.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/28/24.
//

import Foundation

import RxDataSources

enum ChatType {
    case onlyText(DMHistoryTable)
    case onlyImage(DMHistoryTable)
    case TextAndImage(DMHistoryTable)
}

struct ChatSection {
    var items: [ChatType]
}

extension ChatSection: SectionModelType {
    typealias Item = ChatType

    init(original: ChatSection, items: [ChatType]) {
        self = original
        self.items = items
    }
}
