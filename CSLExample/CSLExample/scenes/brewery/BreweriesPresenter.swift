//
//  BreweriesPresenter.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 11/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import UIKit
import PromiseKit
import RealmSwift

protocol BreweriesBusinessLogic {

    func attachDisplayLogic(_ logic: BreweriesDisplayLogic)
    func loadBreweries()
    func breweryClicked(id: Int?)
}

protocol BreweriesDatastore {
    
}

class BreweriesPresenter: BreweriesDatastore {
    private var breweries: Results<Brewery>?
    
    // Weak reference to the ViewController so the Presenter and ViewController aren't in a retain cycle
    private weak var displayLogic: BreweriesDisplayLogic?
}

extension BreweriesPresenter: BreweriesBusinessLogic {
    
    func attachDisplayLogic(_ logic: BreweriesDisplayLogic) {
        
        self.displayLogic = logic
    }
    
    func loadBreweries() {
        firstly {
            BreweryManager.shared.fetchBreweries()
        }.done {
            self.breweries = BreweryManager.shared.getLocalBroweries()
            self.showBreweries()
        }.catch { _ in
            //could handle error here
        }
    }
    
    private func showBreweries() {
        if let breweries = self.breweries, !breweries.isEmpty {
            self.displayLogic?.displayBreweries(breweries: Array(breweries))
        }
    }
    
    func breweryClicked(id: Int?) {
        if let id = id {
            self.displayLogic?.showDetails(id: id)
        }
    }
}
