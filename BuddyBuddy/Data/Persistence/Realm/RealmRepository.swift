//
//  RealmRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/19/24.
//

import Foundation

import RealmSwift

final class RealmRepository<T: Object> {
    private let realm = try? Realm()
    
    func updateItem(_ data: T) {
        do {
            guard let realm else { return }
            try realm.write {
                realm.add(data, update: .modified)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm Error")
        }
    }
    
    func readAllItem() -> [T] {
        guard let realm else { return [] }
        let list = realm.objects(T.self)
        return Array(list)
    }
    
    func detectRealmURL() {
        guard let realm else { return }
        print(realm.configuration.fileURL ?? "No Realm file URL found")
    }
}
