//
//  ViewController.swift
//  Milestone25-27
//
//  Created by Javier Rodríguez Gómez on 25/11/21.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    var topText: String?
    var bottomText: String?
    var imageMeme: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Make your meme"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(selectImage))
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        imageMeme = image
        dismiss(animated: true)
        selectTopText()
    }
    
    func selectTopText() {
        let ac = UIAlertController(title: "Enter top text:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.selectBottomText()
        })
        ac.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if let text = ac.textFields![0].text {
                self.topText = text
            } else { self.topText = "" }
            self.selectBottomText()
        })
        present(ac, animated: true)
    }
    
    func selectBottomText() {
        let ac1 = UIAlertController(title: "Enter bottom text:", message: nil, preferredStyle: .alert)
        ac1.addTextField()
        ac1.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.showMeme()
        })
        ac1.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if let text = ac1.textFields![0].text {
                self.bottomText = text
            } else { self.bottomText = "" }
            self.showMeme()
        })
        present(ac1, animated: true)
    }
    
    func showMeme() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 414, height: 774))
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .foregroundColor: UIColor.orange,
                .paragraphStyle: paragraphStyle
            ]
            
            let attributedTop = NSAttributedString(string: topText ?? "", attributes: attrs)
            let attributedBottom = NSAttributedString(string: bottomText ?? "", attributes: attrs)
            let image = imageMeme!
            attributedTop.draw(with: CGRect(x: 20, y: 20, width: 374, height: 734), options: .usesLineFragmentOrigin,context: nil)
            image.draw(at: CGPoint(x: 20, y: 120))
            attributedBottom.draw(with: CGRect(x: 20, y: 714, width: 374, height: 734), options: .usesLineFragmentOrigin, context: nil)
        }
        imageView.image = img
    }
    
}

