//
//  BreweriesViewController.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 11/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import UIKit

protocol BreweriesDisplayLogic: class {

    func displayBreweries(breweries: [Brewery])
    func showDetails(id: Int)
}

class BreweriesViewController: UIViewController {

    var presenter: (BreweriesBusinessLogic & BreweriesDatastore)?
    var router: BreweriesRoutingLogic?
    private var breweries: [Brewery]?
    @IBOutlet weak var tableView: UITableView!

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
        self.presenter = BreweriesPresenter()
        self.presenter?.attachDisplayLogic(self)
        self.router = BreweriesRouter(source: self)
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "breweryCell")
        self.title = "Breweries"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBreweries()
    }
}

// MARK: logic for calling the presenter
extension BreweriesViewController {

    func loadBreweries() {
        
        presenter?.loadBreweries()
    }
}

// MARK: Input --- Display something
extension BreweriesViewController: BreweriesDisplayLogic {
    func displayBreweries(breweries: [Brewery]) {
        self.breweries = breweries
        self.tableView.reloadData()
    }
    
    func showDetails(id: Int) {
        self.router?.routeToDetail(id: id)
    }
}

extension BreweriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.breweries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breweryCell", for: indexPath)
        if let brewery = self.breweries?[indexPath.row] {
            cell.textLabel?.text = brewery.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let brewery = self.breweries?[indexPath.row] {
            self.presenter?.breweryClicked(id: brewery.id)
        }
    }
}
