//
//  NetworkRequestFailedError.swift
//  Roscom
//
//  Created by Jaap Manenschijn on 20/09/2019.
//  Copyright © 2019 Move4Mobile. All rights reserved.
//

import Foundation

class NetworkRequestFailedError: Error {
    
    // Optional HTTP status code
    var httpStatusCode: Int?
    var localizedDescription: String?
    var apiErrorCode: Int?
    
    convenience init(message: String?) {
        self.init(httpStatusCode: -1, message: message)
    }
    
    init(httpStatusCode: Int?, message: String?) {
        self.httpStatusCode = httpStatusCode
        localizedDescription = message
    }
    
    init(httpStatusCode: Int?, cause: Error?) {
        self.httpStatusCode = httpStatusCode
        localizedDescription = cause?.localizedDescription
    }
    
    init(httpStatusCode: Int?, cause: Error?, errorBody: [String: Any]?) {
        self.httpStatusCode = httpStatusCode
        localizedDescription = cause?.localizedDescription
        if let json = errorBody, let error = json["error"] as? [String: Any], let code = error["code"] as? Int {
            apiErrorCode = code
        }
    }
}
