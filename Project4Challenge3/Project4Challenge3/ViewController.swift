//
//  ViewController.swift
//  Project4Challenge3
//
//  Created by Javier Rodríguez Gómez on 1/5/21.
//

import UIKit

class ViewController: UITableViewController {
    
    let webSites = ["apple.com", "hackingwithswift.com", "applesfera.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Webs"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webSites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        cell.textLabel?.text = webSites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "WebPage") as? WebViewController {
            vc.selectedWeb = webSites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

