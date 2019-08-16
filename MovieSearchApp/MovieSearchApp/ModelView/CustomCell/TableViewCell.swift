//
//  TableViewCell.swift
//  MovieSearchApp
//
//  Created by AlphaDVLPR on 8/16/19.
//  Copyright © 2019 AlphaDVLPR. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var ratingNumberLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //Landing Pad
    var movieObjects: MovieObjects? {
        
        didSet {
            updateViews()
        }
    }
    
    //Update views function
    func updateViews() {
        guard let item = movieObjects else {
            
            moviePosterImage.image = nil
            movieTitleLabel.text = ""
            ratingNumberLabel.text = ""
            descriptionLabel.text = ""
            return
    }
        
        guard let ratingNumber = movieObjects?.rating else {return}
        ratingNumberLabel.text = String(ratingNumber)
        
        //Fetch image
        MovieController.fetchImage(item: item) { (fetchedImage) in
            
            //Update UI
            DispatchQueue.main.async {
                self.moviePosterImage.image = fetchedImage
            }
        }

}
}
