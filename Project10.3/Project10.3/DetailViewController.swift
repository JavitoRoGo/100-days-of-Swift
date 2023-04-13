//
//  DetailViewController.swift
//  Project10.3
//
//  Created by Javier Rodríguez Gómez on 3/6/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage: String?
    var selectedPictureNumber = 0
    var totalPictures = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(selectedPictureNumber) of \(totalPictures)"
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }

    }
    
}
