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
    var planets:[PlanetListResultResponseModel] = []
    var infoPages = 0
    var isLoaded = false
    var page = 1
    var listOfPlanets = [Planet]()
    let ol = CitizenCreateService()
    
    @IBOutlet var planetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPlanets()
        planetTableView.dataSource = self
        planetTableView.delegate = self
        
        HUD.registerForKeyboardNotifications()
        HUD.allowsInteraction = false
        HUD.dimsBackground = true
    }
    
    func changePage() {
        if page < infoPages {
            page = page + 1
            loadPlanets()
        }
    }
    
    func createModelPlanets() {
        for planet in planets {
            let currentPlanet = Planet(name: planet.name ?? "Безымянное", countOfPeople: String (planet.residents.count), type: planet.type ?? "Нечто", residentsUrl: planet.residents)
            listOfPlanets.append(currentPlanet)
            planetTableView.reloadData()
        }
    }
    
    func loadPlanets() {
        HUD.show(.progress)
        networkService.getPlanetList(page: page) { [weak self] (response, error) in
            guard let self = self, let response = response else {
                return
            }
            
            self.planets = response.results
            HUD.hide()
            self.infoPages = response.info.pages
            self.page = self.page + 1
            self.isLoaded = true
            self.createModelPlanets()
        }
    }
}

extension PlanetListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfPlanets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? PlanetTableViewCell else {
            
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        if isLoaded == true {
            cell.locationLabel.text = listOfPlanets[indexPath.row].name
            cell.typeOfLocationLabel.text = listOfPlanets[indexPath.row].type
            cell.countOfPeopleLabel.text = listOfPlanets[indexPath.row].countOfPeople
        }
        
        return cell
    }
}

extension PlanetListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       citizenDataCache.urlArray = listOfPlanets[indexPath.row].residentsUrl
     
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destinationViewController = mainStoryBoard.instantiateViewController(identifier:String(describing: CitizenDetailViewController().theClassName))
        if let citizenUrls = destinationViewController as? CitizenDetailViewController {
            citizenUrls.urlStringlist = listOfPlanets[indexPath.row].residentsUrl
            citizenUrls.planetTitle = listOfPlanets[indexPath.row].name
        }
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == listOfPlanets.count/2 {
            DispatchQueue.global(qos: .utility).async {
                self.networkService.getPlanetList(page: self.page) { [weak self] (response, error) in
                    guard let self = self,
                          let response = response else {
                        return
                    }
                    self.planets = response.results
                }
            }
            DispatchQueue.main.async {
                if self.page >= self.infoPages {return} else {
                    self.page = self.page + 1
                    self.createModelPlanets()
                }
            }
        }
    }
}


