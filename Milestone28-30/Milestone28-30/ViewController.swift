//
//  ViewController.swift
//  Milestone28-30
//
//  Created by Javier Rodríguez Gómez on 30/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Parameters
    
    var pairs: [String]!
    var mixed: [String]!
    var buttons: [UIButton]!
    var touches = [Int]()
    var correctTouches = [Int]()
    
    // MARK: - Outlets
    
    @IBOutlet var cell0: UIButton!
    @IBOutlet var cell1: UIButton!
    @IBOutlet var cell2: UIButton!
    @IBOutlet var cell3: UIButton!
    @IBOutlet var cell4: UIButton!
    @IBOutlet var cell5: UIButton!
    @IBOutlet var cell6: UIButton!
    @IBOutlet var cell7: UIButton!
    @IBOutlet var cell8: UIButton!
    @IBOutlet var cell9: UIButton!
    @IBOutlet var cell10: UIButton!
    @IBOutlet var cell11: UIButton!
    @IBOutlet var cell12: UIButton!
    @IBOutlet var cell13: UIButton!
    @IBOutlet var cell14: UIButton!
    @IBOutlet var cell15: UIButton!
    @IBOutlet var cell16: UIButton!
    @IBOutlet var cell17: UIButton!
    @IBOutlet var cell18: UIButton!
    @IBOutlet var cell19: UIButton!
    
    // MARK: - UI view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pairs = ["😄", "😄", "🐞", "🐞", "💀", "💀", "😊", "😊", "😵‍💫", "😵‍💫", "😶", "😶", "🐱", "🐱", "🐼", "🐼", "🦄", "🦄", "🦕", "🦕"]
        mixed = pairs.shuffled()
        buttons = [cell0, cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, cell9, cell10, cell11, cell12, cell13, cell14, cell15, cell16, cell17, cell18, cell19]
    }
    
    // MARK: - Button action
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let initValue = NSMutableAttributedString(string: "?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 144)])
        let customEmoji = NSMutableAttributedString(string: mixed[sender.tag], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 144)])
        let view1 = sender, view2 = sender
        view1.setAttributedTitle(initValue, for: .normal)
        view2.setAttributedTitle(customEmoji, for: .normal)
        
        switch touches.count {
        case 0:
            touches.append(sender.tag)
            flip(view1: view1, view2: view2)
        case 1:
            touches.append(sender.tag)
            flip(view1: view1, view2: view2)
            if mixed[touches[0]] == mixed[touches[1]] {
                correctTouches += touches
                buttons[touches[0]].isEnabled = false
                buttons[touches[1]].isEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                    self.buttons[self.touches[0]].bounce()
                    self.buttons[self.touches[1]].bounce()
                    self.touches.removeAll(keepingCapacity: true)
                }
                
                if correctTouches.count == pairs.count {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        for button in self.buttons {
                            button.rotation()
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.7, execute: {
                        let ac = UIAlertController(title: "¡HAS GANADO!", message: "Pulsa para volver a jugar.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "¡Otra!", style: .default) { _ in
                            self.correctTouches.removeAll(keepingCapacity: true)
                            self.mixed.shuffle()
                            for button in self.buttons {
                                button.setAttributedTitle(initValue, for: .normal)
                                button.isEnabled = true
                            }
                        })
                        self.present(ac, animated: true)
                    })
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let view3 = self.buttons[self.touches[0]]
                    view3.setAttributedTitle(customEmoji, for: .normal)
                    let view4 = self.buttons[self.touches[0]]
                    view4.setAttributedTitle(initValue, for: .normal)
                    self.flip(view1: view3, view2: view4)
                    
                    let view5 = self.buttons[self.touches[1]]
                    view5.setAttributedTitle(customEmoji, for: .normal)
                    let view6 = self.buttons[self.touches[1]]
                    view6.setAttributedTitle(initValue, for: .normal)
                    self.flip(view1: view5, view2: view6)
                    
                    self.touches.removeAll(keepingCapacity: true)
                }
            }
        default:
            ()
        }
    }
    
    // MARK: - Functions
    
    func flip(view1: UIView, view2: UIView) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: view1, duration: 0.9, options: transitionOptions, animations: {
            view1.isHidden = true
        })
        UIView.transition(with: view2, duration: 0.9, options: transitionOptions, animations: {
            view2.isHidden = false
        })
    }
    
}


extension UIButton {
    
    
    func bounce() {
        UIView.animate(withDuration: 0.8, animations: {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5) // se agranda un factor 1.1 tanto en X como en Y
        }) { (completion) in // aquí se pone ahora lo que tiene que hacer al terminar la acción, que sería volver a su forma original
            UIView.animate(withDuration: 0.8, animations: {
                self.transform = .identity // que vuelva al tamaño original
            }) // aquí finalizamos la totalidad de la acción así que no lleva el bloque completion
        }
    }
    
    func rotation() {
        UIView.animate(withDuration: 0.8, animations: {
            self.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi))
        }) { completion in
            UIView.animate(withDuration: 0.8, animations: {
                self.transform = .identity
            })
        }
    }
}

