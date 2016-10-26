//
//  GithubRepoSearchSettings.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

// Model class that represents the user's search settings
class GithubRepoSearchSettings: NSObject {
    var searchString: String?
    var minStars:Int = 0
    var language: String?
    
    init(searchString: String, minStars: Int, language: String) {
        
        super.init()
        self.searchString = searchString
        self.minStars = minStars
        self.language = language
    }
    
    func copy(with zone: NSZone? = nil) -> GithubRepoSearchSettings {
        let copy = GithubRepoSearchSettings(searchString: self.searchString!, minStars: self.minStars, language: self.language!)
        return copy
    }

}
