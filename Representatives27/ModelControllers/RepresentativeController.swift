//
//  RepresentativeController.swift
//  Representatives27
//
//  Created by Albert Yu on 6/27/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    static let baseURL = URL(string: "http://whoismyrepresentative.com/getall_reps_bystate.php")
    
    static func searchRepresentatives(forstate state: String, completion: @escaping (([Representative]?) -> Void)){
        guard let url = baseURL else { completion(nil); return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let stateQuery = URLQueryItem(name: "state", value: state.lowercased())
        let jsonQuery = URLQueryItem(name: "output", value: "json")
        components?.queryItems = [stateQuery, jsonQuery]
        guard let requestURL = components?.url else {completion(nil); return }
        print(requestURL.absoluteString)
        
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error getting representatives: \(error.localizedDescription)")
            }
            
            // ** Look into.
            guard let data = data, let responseDataString = String(data: data, encoding: .ascii), let fixedData = responseDataString.data(using: .utf8) else {completion(nil); return}
            
            let jsonDecoder = JSONDecoder()
            do {
                let decodedData = try jsonDecoder.decode([String: [Representative]].self, from: fixedData)
                let repArray = decodedData["results"]
                completion(repArray)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
}
