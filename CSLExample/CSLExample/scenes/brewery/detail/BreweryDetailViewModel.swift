//
//  BreweryDetailViewModel.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 12/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import UIKit

import Foundation

struct BreweryDetailViewModel {
    
    let name: String?
    let type: String?
    let street: String?
    let city: String?
    let state: String?
    let country: String?
}

extension Brewery {
    func toDetailViewModel() -> BreweryDetailViewModel {
        return BreweryDetailViewModel(name: name, type: type, street: street, city: city, state: state, country: country)
    }
}
