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
        
        tableView.prefetchDataSource = self
        
        fetchPeople()
    }
    
    private func fetchPeople(nextPage: Bool = false) {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        tableView.backgroundView = activityIndicator
        PersonService.shared.fetchPeople(url: nextPage ? paginationContainer?.next : nil) { paginationContainer, error in
            DispatchQueue.main.async {
                (self.tableView.backgroundView as? UIActivityIndicatorView)?.stopAnimating()
            }
            self.paginationContainer = paginationContainer
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationContainer?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
       
        if !isLoadingCell(for: indexPath) {
            let person = people[indexPath.row]
            
            cell.textLabel?.text = person.name
            cell.detailTextLabel?.text = person.gender
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let personViewController = segue.destination as? PersonViewController {
            personViewController.person = people[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}

extension PersonTableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
          if indexPaths.contains(where: isLoadingCell) {
            self.fetchPeople(nextPage: true)
        }
    }
}

private extension PersonTableViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= people.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
