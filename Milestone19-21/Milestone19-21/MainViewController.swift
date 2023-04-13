//
//  ViewController.swift
//  Milestone19-21
//
//  Created by Javier Rodríguez Gómez on 18/11/21.
//

import UIKit

var notes = [String]()

class MainViewController: UITableViewController {
    
    // MARK: - UI view

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(addNewNote))
        
        let defaults = UserDefaults.standard
        notes = defaults.object(forKey: "notes") as? [String] ?? [String]()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //saveNotes()
        }
    }
    
    // MARK: - Functions
    
    @objc func addNewNote() {
        let ac = UIAlertController(title: "Enter your new note title:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            let newNoteTitle = ac.textFields![0].text ?? ""
            notes.insert(newNoteTitle, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            //self.saveNotes()
        })
        present(ac, animated: true)
    }
    
    func saveNotes() {
        let defaults = UserDefaults.standard
        defaults.set(notes, forKey: "notes")
        defaults.synchronize()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DetailViewController,
        let indexPath = tableView.indexPathForSelectedRow else { return }
        
        vc.title = notes[indexPath.row]
        vc.index = indexPath.row
    }
    
}

