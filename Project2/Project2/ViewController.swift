//
//  ViewController.swift
//  Project2
//
//  Created by Javier Rodríguez Gómez on 27/4/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var counter = 0
    var highestScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .done, target: self, action: #selector(showScore))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteScore))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        loadHighestScore()
        
        askQuestion()
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }

    func askQuestion(action: UIAlertAction! = nil) {
        
        button1.transform = .identity
        button2.transform = .identity
        button3.transform = .identity
        
        if counter == 10 {
            let alert = UIAlertController(title: "You've played 10 times", message: "Your final score is \(score).", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play again", style: .destructive, handler: askQuestion))
            present(alert, animated: true)
            score = 0
            counter = 0
        }
        counter += 1
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "Your socre is \(score). \(countries[correctAnswer].uppercased())"
    }
    
    @IBAction func buttonTaped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
        
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct."
            score += 1
        } else {
            title = "UPS! That's the flag of \(countries[sender.tag].uppercased())."
            score -= 1
        }
        
        if score > highestScore {
            highestScore = score
            save()
            let ac = UIAlertController(title: "Congrats!", message: "You get a high score!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    @objc func showScore() {
        let alertScore = UIAlertController(title: nil, message: "Your actual score is \(score).\nYour highest score is \(highestScore).", preferredStyle: .alert)
        alertScore.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertScore, animated: true)
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(highestScore) {
            let defaults = UserDefaults.standard
            defaults.setValue(savedData, forKey: "score")
        } else {
            print("Failed to save data.")
        }
    }
    
    func loadHighestScore() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "score") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                highestScore = try jsonDecoder.decode(Int.self, from: savedData)
            } catch {
                print("Failed to load data.")
            }
        }
    }
    
    @objc func deleteScore() {
        let ac = UIAlertController(title: "Delete highest score", message: "Are you sure?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .destructive) {_ in
            self.highestScore = 0
        })
        present(ac, animated: true)
    }
    
}

