//
//  TableViewController.swift
//  Extension
//
//  Created by Javier Rodríguez Gómez on 16/7/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var scriptArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newScript))
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scriptArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        cell.textLabel?.text = scriptArray[indexPath.row]
        return cell
    }
    
    // MARK: - Functions
    
    @objc func newScript() {
        let ac = UIAlertController(title: "Add your script.", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = ac.textFields?[0].text else { return }
            self.scriptArray.insert(text, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        })
        present(ac, animated: true)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ActionViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        vc.script.text = scriptArray[indexPath.row]
    }

}
