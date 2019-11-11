//
//  BreweriesViewController.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 11/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import UIKit

protocol BreweriesDisplayLogic: class {

    func displayBreweries(viewModel: BreweriesViewModel)
}

class BreweriesViewController: UIViewController {

    var presenter:  (BreweriesBusinessLogic & BreweriesDatastore)?
    var router: BreweriesRoutingLogic?
    private var breweries: [BreweryViewModel]?
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
    func displayBreweries(viewModel: BreweriesViewModel) {
        self.breweries = viewModel.breweries
        self.tableView.reloadData()
    }
}

extension BreweriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.breweries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breweryCell", for: indexPath)
        if let viewModel = self.breweries?[indexPath.row] {
            cell.textLabel?.text = viewModel.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
