//
//  Model.swift
//  Milestone13-15
//
//  Created by Javier Rodríguez Gómez on 1/7/21.
//

import UIKit

struct Country: Codable {
    let id: String
    let name: String
    var city: String
    var currency: String
}

struct CountryModel {
    var countries: [Country]
    
    init() {
        guard var url = Bundle.main.url(forResource: "DATA", withExtension: "json"),
              let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            countries = []
            return
        }
        let file = documents.appendingPathComponent("DATA").appendingPathExtension("json")
        if FileManager.default.fileExists(atPath: file.path) {
            url = file
        }
        do {
            let json = try Data(contentsOf: url)
            countries = try JSONDecoder().decode([Country].self, from: json)
        } catch {
            print("Error \(error)")
            countries = []
        }
    }
}
