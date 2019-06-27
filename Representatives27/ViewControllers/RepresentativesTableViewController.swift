//
//  RepresentativesTableViewController.swift
//  Representatives27
//
//  Created by Albert Yu on 6/27/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

import UIKit

class RepresentativesTableViewController: UITableViewController {
    var representatives: [Representative] = []{
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var state: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let state = state else {return}
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        title = state
        RepresentativeController.searchRepresentatives(forstate: state) { (representativeArray) in
            guard let representativeArray = representativeArray else {return}
            self.representatives = representativeArray
        }
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representatives.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "representativeCell", for: indexPath) as? RepresentativeTableViewCell else {return UITableViewCell()}
        cell.representative = representatives[indexPath.row]
        return cell
    }
}
