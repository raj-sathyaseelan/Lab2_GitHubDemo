//
//  SettingsDelegate.swift
//  GithubDemo
//
//  Created by Raj Sathyaseelan on 10/22/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsDelegate: class {
    func settings(resultsView: RepoResultsViewController, searchSettings settings: GithubRepoSearchSettings?)
    
}



