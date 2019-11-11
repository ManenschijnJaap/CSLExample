//
//  BreweryManager.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 11/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import PromiseKit

class BreweryManager {
    static let shared = BreweryManager()
    
    func getLocalBroweries() -> Results<Brewery>? {
        if let results = Realm.safeInit()?.objects(Brewery.self) {
            return results
        }
        return nil
    }
    
    func fetchBreweries() -> Promise<Void> {
        return Promise<Void> { seal in
            guard let url = URL(string: "https://api.openbrewerydb.org/breweries") else {
                seal.reject(NetworkRequestFailedError(httpStatusCode: -1, message: "Failed to create URL"))
                return
            }
            
            NetworkManager.shared.unAuth.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
                .validate(statusCode: 200...300)
                .responseArray { (response: DataResponse<[Brewery]>) in
                    if let error = response.error {
                        seal.reject(error)
                    } else if let breweries = response.value {
                        do {
                            let realm = try Realm()
                            try realm.write {
                                realm.delete(realm.objects(Brewery.self))
                                for brewery in breweries {
                                    realm.add(brewery)
                                }
                                seal.fulfill(())
                            }
                        } catch let error {
                            seal.reject(error)
                        }
                    } else {
                        seal.reject(NetworkRequestFailedError(message: "Response was empty"))
                    }
                }
        }
    }
}
