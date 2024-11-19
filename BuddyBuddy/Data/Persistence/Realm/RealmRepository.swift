//
//  RealmRepository.swift
//  BuddyBuddy
//
//  Created by 김성률 on 11/19/24.
//

import Foundation

import RealmSwift

final class RealmRepository<T: Object> {
    private let realm = try! Realm()
    
    func updateItem(_ data: T) {
        do {
            try realm.write {
                realm.add(data, update: .modified)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm Error")
        }
    }
    
    func readAllItem() -> [T] {
        let list = realm.objects(T.self)
        return Array(list)
    }
    
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "No Realm file URL found")
    }
}
