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
    var planets:[PlanetListResultResponseModel]=[]
    var isLoaded = 0
    var page = 1
    var listOfPlanets = [Planet]()
    
    @IBOutlet var planetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlanets()
        planetTableView.dataSource = self
        planetTableView.delegate = self
        
        HUD.registerForKeyboardNotifications()
        HUD.allowsInteraction = false
        HUD.dimsBackground = true
        loadPlanets()
        
        print (listOfPlanets)
        DispatchQueue.global().async {
        }
    }
    
    func createModelPlanets(){
        for planet in planets {
            let planets = Planet(name: planet.name ?? "Безымянное", countOfPeople: String (planet.residents.count), type: planet.type ?? "Нечто")
            listOfPlanets.append(planets)
        }
    }
    
    func loadPlanets(){
        HUD.show(.progress)
        networkService.getPlanetList(page: page) { [weak self] (response, error) in
            guard let self = self else {return}
            guard let response = response else {return}
            self.planets = response.results
            HUD.hide()
            self.planetTableView.reloadData()
            self.isLoaded = 1
            self.createModelPlanets()
        }
    }}

extension PlanetListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? PlanetTableViewCell else
        {
            return UITableViewCell()
        }
        
        if isLoaded == 1{
            cell.locationLabel.text = listOfPlanets[indexPath.row].name
            cell.typeOfLocationLabel.text = listOfPlanets[indexPath.row].type
            cell.countOfPeopleLabel.text = listOfPlanets[indexPath.row].countOfPeople
        }
        return cell
    }
}

extension PlanetListViewController: UITableViewDelegate {
    
}

