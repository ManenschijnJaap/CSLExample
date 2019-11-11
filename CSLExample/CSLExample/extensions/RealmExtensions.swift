//
//  RealmExtensions.swift
//  Roscom
//
//  Created by Jaap Manenschijn on 24/09/2019.
//  Copyright © 2019 Move4Mobile. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    static func safeInit() -> Realm? {
        do {
            let realmInstance = try Realm()
            return realmInstance
        } catch let error {
            print("Failed to initialize Realm instance: \(error.localizedDescription)")
            return nil
        }
    }
    
    static func truncateDatabase() {
        let realm = self.safeInit()
        try? realm?.write {
            realm?.deleteAll()
        }
    }
}
