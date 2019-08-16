//
//  MovieObjects.swift
//  MovieSearchApp
//
//  Created by AlphaDVLPR on 8/16/19.
//  Copyright © 2019 AlphaDVLPR. All rights reserved.
//

import Foundation

struct TopLevelDictionary : Codable {
    
    let results: [MovieObjects]
}

struct MovieObjects : Codable {
    
    let title : String
    let rating : Double
    let summary : String
    let image : String
    
    private enum CodingKets : String, CodingKey {
        case title
        case rating = "vote_average"
        case summary = "overview"
        case image = "poster_path"
    }
}
