//
//  ServicePerson.swift
//  StarWarsApp
//
//  Created by Fábio Pereira on 10/12/19.
//  Copyright © 2019 Fábio Pereira. All rights reserved.
//

import Foundation

class PersonService: Service {
    
    static let shared = PersonService()
    
    func getPerson(by id: Int) {
        let path = "people/\(id)"
        
        performeRequest(url: baseUrl + path) { data, error in
            
            guard error == nil else {
                print("Service error: \(error!.localizedDescription)")
                return
            }

            do {
                let person = try JSONDecoder().decode(Person.self, from: data!)
                print(person.name)
            } catch {
                print("Decode error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPeople(url: String? = nil, complition: @escaping (_ data: PaginationContainer?,_ error: Error?) -> Void) {
        
        let path = "people"
        
        performeRequest(url: url == nil ? baseUrl + path : url!) { data, error in

            guard error == nil else {
                complition(nil, error)
                return
            }
            
            do {
                let paginationContainer = try JSONDecoder().decode(PaginationContainer.self, from: data!)
                complition(paginationContainer, nil)
            } catch {
                complition(nil, error)
            }
        }
    }

}
