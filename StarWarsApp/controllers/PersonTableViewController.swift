//
//  PersonTableViewController.swift
//  StarWarsApp
//
//  Created by Fábio Pereira on 10/12/19.
//  Copyright © 2019 Fábio Pereira. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {

    private let cellIdentifier = "personCell"
    private var people: [Person] = []
    private var paginationContainer: PaginationContainer? = nil {
        didSet {
            tableView.backgroundView = nil
            if let paginationContainer = self.paginationContainer {
                people.append(contentsOf: paginationContainer.results)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    let labelNoData = UILabel()
                    labelNoData.text = "No data found"
                    self.tableView.backgroundView = labelNoData
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPeople()
    }
    
    private func loadPeople() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        tableView.backgroundView = activityIndicator
        PersonService.shared.getPeople() { paginationContainer, error in
            DispatchQueue.main.async {
                (self.tableView.backgroundView as! UIActivityIndicatorView).stopAnimating()
            }
            self.paginationContainer = paginationContainer
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let person = people[indexPath.row]
        
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.gender
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let personViewController = segue.destination as? PersonViewController {
            personViewController.person = people[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}
