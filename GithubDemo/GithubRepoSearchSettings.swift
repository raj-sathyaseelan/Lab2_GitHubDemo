//
//  GithubRepoSearchSettings.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation


struct Language {
    var name: String
    var selected: Bool
}

// Model class that represents the user's search settings
class GithubRepoSearchSettings: NSObject {
    var searchString: String?
    var minStars:Int = 0
    
    var language: [Language]!
    
    init(searchString: String, minStars: Int, language: [Language]) {
        
        super.init()
        self.searchString = searchString
        self.minStars = minStars
        self.language = language
    }
    
    func copy(with zone: NSZone? = nil) -> GithubRepoSearchSettings {
        let copy = GithubRepoSearchSettings(searchString: self.searchString!, minStars: self.minStars, language: self.language)
        return copy
    }

}
