//
//  MyImage.swift
//  Milestone10-12
//
//  Created by Javier Rodríguez Gómez on 15/6/21.
//

import UIKit

class MyImage: NSObject {
    
    var image: String
    var caption: String
    
    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
}
