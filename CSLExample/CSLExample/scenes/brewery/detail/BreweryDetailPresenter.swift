//
//  BreweryDetailPresenter.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 12/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import UIKit

protocol BreweryDetailBusinessLogic {

    func attachDisplayLogic(_ logic: BreweryDetailDisplayLogic)
    func loadDetails()
    func removeFromDatabase()
}

protocol BreweryDetailDatastore {
    
    var id: Int? { get set }
}

class BreweryDetailPresenter: BreweryDetailDatastore {
    
    // Local list, not available outside this class
    // var products: [Product]?
    // Implementation of the datastore
    var id: Int?
    
    // Weak reference to the ViewController so the Presenter and ViewController aren't in a retain cycle
    private weak var displayLogic: BreweryDetailDisplayLogic?
}

extension BreweryDetailPresenter: BreweryDetailBusinessLogic {
    
    func attachDisplayLogic(_ logic: BreweryDetailDisplayLogic) {
        
        self.displayLogic = logic
    }
    
    func loadDetails() {
        if let id = id, let brewery = BreweryManager.shared.getBrewery(id: id) {
            self.displayLogic?.displayDetails(viewModel: brewery.toDetailViewModel())
        }
    }
    
    func removeFromDatabase() {
        if let id = id {
            BreweryManager.shared.deleteBrewery(id: id)
        }
    }
}
