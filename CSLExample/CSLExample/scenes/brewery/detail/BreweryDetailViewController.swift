//
//  BreweryDetailViewController.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 12/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import UIKit

protocol BreweryDetailDisplayLogic: class {
    
    func displayDetails(brewery: Brewery)
}

class BreweryDetailViewController: UIViewController {
    
    var presenter: (BreweryDetailBusinessLogic & BreweryDetailDatastore)?
    var router: BreweriesRoutingLogic?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    private var brewery: Brewery?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        
        // default CSL setup
        self.presenter = BreweryDetailPresenter()
        self.presenter?.attachDisplayLogic(self)
        self.router = BreweriesRouter(source: self)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadDetails()
    }
}

// MARK: logic for calling the presenter
extension BreweryDetailViewController {
    
    func loadDetails() {
        
        presenter?.loadDetails()
    }
    
    @IBAction func deleteButtonPressed() {
        self.presenter?.removeFromDatabase()
    }
    
    //For some reason, we want to redraw everything. Since we still know all the data (by reference), lets just redraw it.
    @IBAction func redrawButtonPressed() {
        self.showBreweryInView()
    }
}

// MARK: Input --- Display something
extension BreweryDetailViewController: BreweryDetailDisplayLogic {
    
    func displayDetails(brewery: Brewery) {
        self.brewery = brewery
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
