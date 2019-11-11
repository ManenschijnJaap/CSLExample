//
//  NetworkManager.swift
//  Roscom
//
//  Created by Jaap Manenschijn on 18/09/2019.
//  Copyright © 2019 Move4Mobile. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    let unAuth = SessionManager()
    
    override init() {
        
    }
}
