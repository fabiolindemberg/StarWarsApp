//
//  Service.swift
//  StarWarsApp
//
//  Created by Fábio Pereira on 10/12/19.
//  Copyright © 2019 Fábio Pereira. All rights reserved.
//

import Foundation

class Service {
    let baseUrl = "https://swapi.co/api/"
    
    func performeRequest(url: String, complition: @escaping (_ data: Data?, _ error: Error?)->Void) {
        print("Request against: \(url)")
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            print("Response from: \(url)")
            complition(data, error)
        }.resume()
    }

}

struct PaginationContainer: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Person]
}
