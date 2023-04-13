//
//  ViewController.swift
//  Milestone4-6
//
//  Created by Javier Rodríguez Gómez on 22/5/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var itemsList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping list"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        
        navigationController?.isToolbarHidden = false
        let leftButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearList))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [leftButton, space]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        cell.textLabel?.text = itemsList[indexPath.row]
        return cell
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Enter new item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        let action = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.itemsList.insert(item, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    @objc func clearList() {
        itemsList.removeAll()
        tableView.reloadData()
    }
    
    @objc func shareList() {
        let list = itemsList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        present(vc, animated: true)
    }
    

}

