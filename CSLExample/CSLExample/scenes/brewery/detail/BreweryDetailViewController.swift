//
//  BreweryDetailViewController.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 12/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import UIKit

class BreweryDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    private var brewery: Brewery?
    var id: Int?
    
    // MARK: Object lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadDetails()
    }
    
    func loadDetails() {
        if let id = id, let brewery = BreweryManager.shared.getBrewery(id: id) {
            self.brewery = brewery
            self.showBreweryInView()
        }
    }
    
    @IBAction func deleteButtonPressed() {
        if let id = id {
            BreweryManager.shared.deleteBrewery(id: id)
        }
    }
    
    //For some reason, we want to redraw everything. Since we still know all the data (by reference), lets just redraw it.
    @IBAction func redrawButtonPressed() {
        self.showBreweryInView()
    }
    
    //Reads from the model & shows it on screen
    private func showBreweryInView() {
        
        self.nameLabel.text = brewery?.name
        self.typeLabel.text = brewery?.type
        self.streetLabel.text = brewery?.street
        self.cityLabel.text = brewery?.city
        self.stateLabel.text = brewery?.state
        self.countryLabel.text = brewery?.country
    }
}
