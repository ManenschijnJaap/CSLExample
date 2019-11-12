//
//  BreweriesViewController.swift
//  CSLExample
//
//  Created by Jaap Manenschijn on 11/11/2019.
//  Copyright © 2019 Jaap Manenschijn. All rights reserved.
//

import UIKit
import PromiseKit
import RealmSwift

class BreweriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var breweries: Results<Brewery>?
    
    // MARK: Object lifecycle
    
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
    
    func loadBreweries() {
        
        firstly {
            BreweryManager.shared.fetchBreweries()
        }.done {
            self.breweries = BreweryManager.shared.getLocalBroweries()
            self.tableView.reloadData()
        }.catch { _ in
            //could handle error here
        }
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
            guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BreweryDetailViewController") as? BreweryDetailViewController else {
                return
            }
            
            vc.id = brewery.id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
