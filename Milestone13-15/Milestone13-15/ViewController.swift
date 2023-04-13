//
//  ViewController.swift
//  Milestone13-15
//
//  Created by Javier Rodríguez Gómez on 1/7/21.
//

import UIKit

var countryModel = CountryModel()

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Countries"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryModel.countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        let country = countryModel.countries
        cell.textLabel?.text = country[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController {
            vc.countryDetail = countryModel.countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

