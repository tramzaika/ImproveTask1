//
//  PlanetListViewController.swift
//  improveTask1
//
//  Created by 1234 on 05.04.2021.
//  Copyright © 2021 Lisa. All rights reserved.
//

import Foundation
import UIKit
import PKHUD


class PlanetListViewController: UIViewController {
    let networkService: PlanetsListNetworkService = NetworkService()
    var planets:[PlanetListResultResponceModel]=[]
    var isLoaded = 0
    var page = 1
    
    @IBOutlet var planetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlanets()
        planetTableView.dataSource = self
        planetTableView.delegate = self
        
        HUD.registerForKeyboardNotifications()
        HUD.allowsInteraction = false
        HUD.dimsBackground = true
        DispatchQueue.global().async {
            self.loadPlanets()
        }
    }
    
    func loadPlanets(){
        HUD.show(.progress)
        networkService.getPlanetList(page: page) { [weak self] (response, error) in
            guard let self = self else {return}
            self.planets = response!.results
            HUD.hide()
            self.planetTableView.reloadData()
            self.isLoaded = 1
        }
    }}

extension PlanetListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? PlanetTableViewCell else
        {
            fatalError("Not found cell")
        }
        
        if isLoaded == 1{
            cell.locationLabel.text = planets[indexPath.row].name
            cell.typeOfLocationLabel.text = planets[indexPath.row].type
            cell.CountOfPeopleLabel.text = String(planets[indexPath.row].residents.count)
        }
        return cell
    }
}

extension PlanetListViewController: UITableViewDelegate {
    
}

