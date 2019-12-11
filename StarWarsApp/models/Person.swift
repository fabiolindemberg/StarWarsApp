//
//  Person.swift
//  StarWarsApp
//
//  Created by Fábio Pereira on 10/12/19.
//  Copyright © 2019 Fábio Pereira. All rights reserved.
//

import Foundation

struct Person : Decodable {
    let name: String
    let birth_year: String?
    let eye_color: String?
    let gender: String?
    let hair_color: String?
    let height: String?
    let skin_color: String?
}
