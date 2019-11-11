//
//  BreweriesViewModel.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 11/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import UIKit

import Foundation

struct BreweriesViewModel {
    
    let breweries: [BreweryViewModel]?
}

struct BreweryViewModel {
    let id: Int?
    let name: String?
}

extension Brewery {
    func toBreweryViewModel() -> BreweryViewModel {
        return BreweryViewModel(id: self.id, name: self.name)
    }
}
