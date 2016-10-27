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


class SettingsViewController: UITableViewController, SettingsViewControllerDelegate, MinStarsTableViewCellDelegate {
    
    var searchSettings = GithubRepoSearchSettings(searchString: "", minStars: 1000, language: [Language]())
    weak var delegate: SettingsViewControllerDelegate?
    
    @IBOutlet var settingsTableView: UITableView!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var settingsDelegate: SettingsViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = settingsDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveBarButtonAction(_ sender: AnyObject) {
        print("Save pressed")
        dismiss(animated: true, completion: nil)
        self.delegate?.settingsView!(settingsView: self, didSettingsChange: searchSettings)
    }
    
    @IBAction func cancelButtonAction(_ sender: AnyObject) {
        print("cancel pressed")
        
    }
    
    //Delegate override method
    func settingsView(settingsView: SettingsViewController, didSettingsChange settings: GithubRepoSearchSettings?) {
        //
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
            return 1
        }
        else if section == 1 {
            return searchSettings.language.count
        }
        else {
            return 0
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if ( indexPath.section == 0 ) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MinStarsTableViewCell", for: indexPath) as! MinStarsTableViewCell
            
            cell.minStarsSlider.minimumValue = 1000
            cell.minStarsSlider.maximumValue = 5000
            
            //cell.minStarsSlider.value = 1000
            //cell.minStarsValueLabel.text = "1000"
            
            
            // Do any additional setup after loading the view.
            
            
            cell.minStarsSlider.value = Float("\(searchSettings.minStars)")!
            cell.minStarsValueLabel.text = "\(searchSettings.minStars)"
            cell.delegate = self
            return cell
            
        }
        else if (indexPath.section == 1 ) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath) as! LanguageTableViewCell
            
            cell.textLabel?.text = searchSettings.language[indexPath.row].name
            return cell
            
        }
        else {
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0 ) {
            return "Minimum Stars"
        }
        else if(section == 1) {
            return "Language"
        }
        else {
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 1 ) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath) as! LanguageTableViewCell
            //cell.accessoryType = UITableViewCellAccessoryType.checkmark
            
            
            if cell.accessoryType == UITableViewCellAccessoryType.checkmark {
                cell.accessoryType = UITableViewCellAccessoryType.none
                searchSettings.language[indexPath.row].selected = false
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                searchSettings.language[indexPath.row].selected = true
            }
            
            

        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1 ) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath) as! LanguageTableViewCell
            cell.accessoryType = UITableViewCellAccessoryType.none
            
            /*
            
            if cell.accessoryType == UITableViewCellAccessoryType.checkmark {
                cell.accessoryType = UITableViewCellAccessoryType.none
                searchSettings.language[indexPath.row] = false
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                searchSettings.language[indexPath.row] = true
            }
            */
        }

    }
    
    func minStars(minsStarsCell: MinStarsTableViewCell, didSliderChange slider: UISlider!) {
        searchSettings.minStars = Int(slider.value)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if ((sender as? UIBarButtonItem) != nil) {
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            //meal = Meal(name: name, photo: photo, rating: rating)
            //self.searchSettings.minStars = Int(minStarsSlider.value)
            
            delegate?.settingsView?(settingsView: self, didSettingsChange: searchSettings.copy())
            
        }
        
    }

}

//Create a delegate to update the settings.
@objc protocol MinStarsTableViewCellDelegate: class {
    @objc optional func minStars(minsStarsCell: MinStarsTableViewCell, didSliderChange slider: UISlider!)
}

class MinStarsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var minStarsValueLabel: UILabel!
    @IBOutlet weak var minStarsSlider: UISlider!
    
    var delegate: MinStarsTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    @IBAction func minStarssliderChanged(_ sender: AnyObject) {
        minStarsValueLabel.text =  "\(minStarsSlider.value)"
        delegate.minStars!(minsStarsCell: self, didSliderChange: minStarsSlider)
    }

}

class LanguageTableViewCell: UITableViewCell {
    
    var searchSettings: GithubRepoSearchSettings!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
