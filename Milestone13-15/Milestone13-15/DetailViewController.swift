//
//  DetailViewController.swift
//  Milestone13-15
//
//  Created by Javier Rodríguez Gómez on 1/7/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var abrevLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var countryDetail: Country?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        showData()
    }
    
    func showData() {
        guard let country = countryDetail else { return }
        
        title = country.name
        abrevLabel.text = country.id
        cityLabel.text = country.city
        currencyLabel.text = country.currency
    }
    
}
