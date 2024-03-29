//
//  BreweriesRouter.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 11/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import UIKit

protocol BreweriesRoutingLogic {
    
    func routeToDetail(id: Int)
}

class BreweriesRouter: BaseRouter, BreweriesRoutingLogic {
    
    // MARK: Routing
    
    func routeToDetail(id: Int) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BreweryDetailViewController") as? BreweryDetailViewController else {
            return
        }
        
        vc.presenter?.id = id
        navigate(vc, .push)
    }
    
}
