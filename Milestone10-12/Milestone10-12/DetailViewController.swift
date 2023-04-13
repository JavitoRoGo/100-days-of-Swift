//
//  DetailViewController.swift
//  Milestone10-12
//
//  Created by Javier Rodríguez Gómez on 16/6/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedPicture: MyImage?

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let picture = selectedPicture {
            title = picture.caption
            let path = getDocumentsDirectory().appendingPathComponent(picture.image)
            imageView.image = UIImage(contentsOfFile: path.path)
        }
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
