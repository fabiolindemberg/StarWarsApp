//
//  PersonViewController.swift
//  StarWarsApp
//
//  Created by Fábio Pereira on 10/12/19.
//  Copyright © 2019 Fábio Pereira. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbBirthYear: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbSkinColor: UILabel!
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let person = self.person {
            fillPersonInfo(person: person)
        }
    }
    
    private func fillPersonInfo(person: Person) {
        lbName.text = person.name
        lbBirthYear.text = person.birth_year ?? "N/A"
        lbGenre.text = person.gender ?? "N/A"
        lbSkinColor.text = person.skin_color
    }
}
