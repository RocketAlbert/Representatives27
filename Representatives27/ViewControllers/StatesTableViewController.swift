//
//  StatesTableViewController.swift
//  Representatives27
//
//  Created by Albert Yu on 6/27/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

import UIKit

class StatesTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return States.all.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        let state = States.all[indexPath.row]
        cell.textLabel?.text = state
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRepresentativeVC" {
            guard let destinationVC = segue.destination as? RepresentativesTableViewController,
                let index = tableView.indexPathForSelectedRow else { return }
            destinationVC.state = States.all[index.row]
    }
}
}
