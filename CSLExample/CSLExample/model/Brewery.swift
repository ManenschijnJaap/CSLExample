//
//  LeaveRequest.swift
//  Roscom
//
//  Created by Jaap Manenschijn on 04/11/2019.
//  Copyright © 2019 Move4Mobile. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Brewery: Object, Mappable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var type: String?
    @objc dynamic var street: String?
    @objc dynamic var city: String?
    @objc dynamic var state: String?
    @objc dynamic var postalCode: String?
    @objc dynamic var country: String?
    @objc dynamic var phone: String?
    @objc dynamic var website: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        type <- map["brewery_type"]
        street <- map["street"]
        city <- map["city"]
        state <- map["state"]
        postalCode <- map["postal_code"]
        country <- map["country"]
        phone <- map["phone"]
        website <- map["website"]
    }
}
