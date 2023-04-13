//
//  DetailViewController.swift
//  Milestone19-21
//
//  Created by Javier Rodríguez Gómez on 18/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var index: Int?
    
    // MARK: - Outlets
    
    @IBOutlet var textOutlet: UITextView!
    
    // MARK: - UI view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isToolbarHidden = false
                
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(saveText))
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteText))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [deleteButton, spacer, saveButton]
        
        if let index = index {
            textOutlet.text = notes[index]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.isToolbarHidden = false
    }
    
    // MARK: - Functions
    
    @objc func saveText() {
        notes[index!] = textOutlet.text
        title = textOutlet.text
    }
    
    @objc func deleteText() {
        textOutlet.text = ""
    }
    
}
