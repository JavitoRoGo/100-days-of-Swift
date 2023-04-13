//
//  ViewController.swift
//  Milestone7-9
//
//  Created by Javier Rodríguez Gómez on 30/5/21.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Setting parameters
    
    var allWords = [String]()
    var word = ""
    var usedLetters = [String]()
    var promptWord = ""
    var numsOfFails = 0
    var numsOfGuess = 0
    
    // MARK: - UI view

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chargeWords()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Start", style: .plain, target: self, action: #selector(startGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptAnswer))
        
        startGame()
    }
    
    // MARK: - Editing tableview
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usedLetters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zelda", for: indexPath)
        cell.textLabel?.text = usedLetters[indexPath.row]
        return cell
    }
    
    // MARK: - Functions
    
    func chargeWords() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                    allWords = startWords.components(separatedBy: "\n")
            }
        } else {
            allWords = ["silkworm"]
        }
    }
    
    @objc func startGame() {
        word = allWords.randomElement()!
        usedLetters.removeAll(keepingCapacity: true)
        promptWord = ""
        numsOfFails = 0
        numsOfGuess = 0
        for _ in 1...word.count {
            promptWord += "?"
        }
        title = promptWord + " - Fails: \(numsOfFails)"
        tableView.reloadData()
    }
    
    @objc func promptAnswer() {
        let ac = UIAlertController(title: "Enter letter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { action in
            guard let answer = ac.textFields?[0].text else { return }
            if answer.count == 1 {
                self.submit(answer)
            } else {
                let ac = UIAlertController(title: "Error", message: "Type just one letter.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: { action in
                    self.promptAnswer() }))
                self.present(ac, animated: true)
            }
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        if !usedLetters.contains(answer) {
            usedLetters.insert(answer, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            
            if word.contains(answer) {
                promptWord = ""
                for letter in word {
                    let strLetter = String(letter)
                    if usedLetters.contains(strLetter) {
                        promptWord += strLetter
                    } else {
                        promptWord += "?"
                    }
                }
                numsOfGuess += 1
                title = promptWord + " - Fails: \(numsOfFails)"
            } else {
                numsOfFails += 1
                title = promptWord + " - Fails: \(numsOfFails)"
            }
        } else {
            let ac = UIAlertController(title: "Oops!", message: "You've already used letter \"\(answer)\".", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac, animated: true)
            return
        }
        
        if numsOfGuess == word.count {
            let ac = UIAlertController(title: "You win!", message: "The word to guess was \"\(word)\".", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play again", style: .cancel, handler: {action in
                self.startGame() }))
            present(ac, animated: true)
        }
        
        if numsOfFails == 7 {
            let ac = UIAlertController(title: "Game over!", message: "The word to guess was \"\(word)\".", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play again", style: .cancel, handler: {action in
                self.startGame() }))
            present(ac, animated: true)
        }
    }
    
    
}

