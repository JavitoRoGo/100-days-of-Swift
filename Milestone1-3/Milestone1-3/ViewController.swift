//
//  ViewController.swift
//  Milestone1-3
//
//  Created by Javier Rodríguez Gómez on 28/4/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var countriesName = [String]()
    var countriesFlag = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasSuffix("png") {
                countriesFlag.append(item)
                var newItem = item.uppercased()
                newItem.removeLast(4)
                countriesName.append(newItem)
            }
        }
        countriesName.sort()
        countriesFlag.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection numberOfRows: Int) -> Int {
        return countriesName.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        cell.textLabel?.text = countriesName[indexPath.row]
        cell.imageView?.image = UIImage(named: countriesFlag[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "FlagDetail") as? DetailViewController {
            vc.selectedCountry = countriesName[indexPath.row]
            vc.selectedFlag = countriesFlag[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

