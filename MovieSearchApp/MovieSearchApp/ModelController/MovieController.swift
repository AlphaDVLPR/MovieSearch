//
//  MovieController.swift
//  MovieSearchApp
//
//  Created by AlphaDVLPR on 8/16/19.
//  Copyright © 2019 AlphaDVLPR. All rights reserved.
//

import Foundation
import UIKit.UIImage

class MovieController {
    
    //Fetch Item
    static func fetchItem(searchTerm : String, completion: @escaping ([MovieObjects])-> Void){
        
        //URL
        //89e4f2c080deaadb142502d9394694cc
        
        let key = "89e4f2c080deaadb142502d9394694cc"
        guard let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie") else {completion([]) ; return}
        
        let keyQueryItem = URLQueryItem(name: "api_key", value: key)
        let searchQueryItem = URLQueryItem(name: "query", value: searchTerm)
        
        //create Url components
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        //add query items to the url Components
        urlComponents?.queryItems = [keyQueryItem, searchQueryItem]
        
        //Create a final URL with all of the components
        guard let finalURL = urlComponents?.url else {completion([]); return}
        print(finalURL)
        
        //So this is the URL session
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            
            //So this is to handle the errors
            //guard let error = error else {completion([]); return }
            if let error = error {
                print("YOU GOT TRUST ISSUES")
            }
            guard let data = data else {completion([]); return}
            
            //DECODE
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(topLevelDictionary.results)
                
            } catch {
                print("ISSUES BROSKI\(error.localizedDescription) \(#function)")
            }
            }.resume()
    }
    
    //Now we are creating the Image
    static func fetchImage(item: MovieObjects, completion: @escaping (UIImage?) -> Void) {
        
        //baseURL
        guard var baseURL = URL(string: "http://image.tmdb.org/t/p/w500") else {completion(nil); return}
        
        baseURL.appendPathComponent(item.image)
        
        //get the url
        guard let imageURL = URL(string: baseURL) else {completion(nil); return}
        print(imageURL)
        
        //url session
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            
            //Do the errors
            if let error = error {
                print("GET IT TOGETHER BROOOOO")
                
            }
            
            //verify if we got the data
            guard let data = data else {completion(nil); return}
            
            //init and complete
            let imageUrl = UIImage(data: data)
            completion(imageUrl)
            }.resume()
    }
    
}
