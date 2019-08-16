//
//  MovieTableViewController.swift
//  MovieSearchApp
//
//  Created by AlphaDVLPR on 8/16/19.
//  Copyright © 2019 AlphaDVLPR. All rights reserved.
//

import UIKit

//Dont forget the search bar delegate G sauce
class MovieTableViewController: UITableViewController, UISearchBarDelegate {

    //OUTLETS
    @IBOutlet weak var searchbar: UISearchBar!
    
    var items: [MovieObjects] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchbar.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //lets guard this unit right here broooo
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? TableViewCell else {return UITableViewCell()}

        // Configure the cell...
        let item = items[indexPath.row]
        cell.movieObjects = item
        return cell
    }
    
    //SEARCH BAR
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchbar.text,
            !searchTerm.isEmpty else {return}
        
        MovieController.fetchItem(searchTerm: searchTerm) { (movies) in
            self.items = movies
            
            //then update UI
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


}
