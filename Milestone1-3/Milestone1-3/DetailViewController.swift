//
//  DetailViewController.swift
//  Milestone1-3
//
//  Created by Javier Rodríguez Gómez on 29/4/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    
    var selectedCountry: String?
    var selectedFlag: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
        
        flagImage.layer.borderColor = UIColor.lightGray.cgColor
        flagImage.layer.borderWidth = 1
        
        flagImage.image = UIImage(named: selectedFlag!)
        countryLabel.text = selectedCountry!
    }
    
    @objc func shareFlag() {
        guard let image = flagImage.image?.pngData() else {
            return
        }
        let vc = UIActivityViewController(activityItems: [image, selectedCountry!], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
