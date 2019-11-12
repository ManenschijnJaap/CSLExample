//
//  BreweryDetailViewController.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 12/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import UIKit

protocol BreweryDetailDisplayLogic: class {
    
    func displayDetails(viewModel: BreweryDetailViewModel)
}

class BreweryDetailViewController: UIViewController {
    
    var presenter:  (BreweryDetailBusinessLogic & BreweryDetailDatastore)?
    var router: BreweriesRoutingLogic?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    private var viewModel: BreweryDetailViewModel?
    
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
    
    //We want to redraw for some reason. Since we still have the reference to the viewModel, lets just redraw everything
    @IBAction func redrawButtonPressed() {
        self.showViewModelInView()
    }
}

// MARK: Input --- Display something
extension BreweryDetailViewController: BreweryDetailDisplayLogic {
    
    func displayDetails(viewModel: BreweryDetailViewModel) {
        self.viewModel = viewModel
        self.showViewModelInView()
    }
    
    //Shows data of the model directly on the screen
    private func showViewModelInView() {
        
        self.nameLabel.text = viewModel?.name
        self.typeLabel.text = viewModel?.type
        self.streetLabel.text = viewModel?.street
        self.cityLabel.text = viewModel?.city
        self.stateLabel.text = viewModel?.state
        self.countryLabel.text = viewModel?.country
    }
}
