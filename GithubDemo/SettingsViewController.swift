//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Raj Sathyaseelan on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import Foundation


@objc protocol SettingsViewControllerDelegate: class {
    @objc optional func settingsView(settingsView: SettingsViewController, didSettingsChange settings: GithubRepoSearchSettings?)
}


class SettingsViewController: UITableViewController, SettingsViewControllerDelegate {
    
    var searchSettings: GithubRepoSearchSettings!
    weak var delegate: SettingsViewControllerDelegate?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var minStarsValueLabel: UILabel!
    @IBOutlet weak var minStarsSlider: UISlider!
    
    weak var settingsDelegate: SettingsViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        minStarsSlider.minimumValue = 1000
        minStarsSlider.maximumValue = 100000

        // Do any additional setup after loading the view.
        
        if searchSettings != nil {
            minStarsSlider.value = Float("\(searchSettings.minStars)")!
            minStarsValueLabel.text = "\(searchSettings.minStars)"
        } else {
            minStarsSlider.value = 1000
            minStarsValueLabel.text = "1000"
        }
        
        self.delegate = settingsDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveBarButtonAction(_ sender: AnyObject) {
        print("Save pressed")
        self.searchSettings.minStars = Int(minStarsSlider.value)
    }
    
    @IBAction func cancelButtonAction(_ sender: AnyObject) {
        print("cancel pressed")
        dismiss(animated: true, completion: nil)
    }
    
    //Delegate override method
    func settings(resultsView: SettingsViewControllerDelegate, searchSettings settings: GithubRepoSearchSettings?) {
        
    }
    
    @IBAction func minStarssliderChanged(_ sender: AnyObject) {
        
        minStarsValueLabel.text =  "\(minStarsSlider.value)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ((sender as? UIBarButtonItem) != nil) {
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            //meal = Meal(name: name, photo: photo, rating: rating)
            //self.searchSettings.minStars = Int(minStarsSlider.value)
            
            delegate?.settingsView?(settingsView: self, didSettingsChange: searchSettings)
            
        }
    }

}
