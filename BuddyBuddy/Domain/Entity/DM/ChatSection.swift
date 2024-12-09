//
//  ChatSection.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/28/24.
//

import Foundation

import RxDataSources

enum ChatType<T> {
    case onlyText(T)
    case onlyImage(T)
    case TextAndImage(T)
}

struct ChatSection<T> {
    var items: [ChatType<T>]
}

extension ChatSection: SectionModelType {
    typealias Item = ChatType<T>

    init(original: ChatSection, items: [ChatType<T>]) {
        self = original
        self.items = items
    }
}
