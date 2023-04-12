//
//  ViewController.swift
//  Project3
//
//  Created by Javier Rodríguez Gómez on 27/4/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
            // Es un tipo de dato que nos permite trabajar con filesystem, y lo usaremos para buscar archivos
        let path = Bundle.main.resourcePath!
            // path se establece en la ruta de los recursos del directorio (bundle) de la app. Viene a ser "dime donde puedo encontrar las imágenes que añadimos"
        let items = try! fm.contentsOfDirectory(atPath: path)
            // items is set a los contenidos del directorio de la ruta indicada, en este caso, la creada en la línea anterior. Tendremos un array de strings con nombres de archivo
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1. Try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2. Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            // estas dos líneas son del challenge
            vc.selectedPictureNumber = indexPath.row + 1
            vc.totalPictures = pictures.count
            // 3. Now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

