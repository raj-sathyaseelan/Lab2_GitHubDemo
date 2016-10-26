//
//  GithubRepoTableViewCell.swift
//  GithubDemo
//
//  Created by Raj Sathyaseelan on 10/21/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class GithubRepoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoStarsLabel: UILabel!
    @IBOutlet weak var repoForksLabel: UILabel!
    @IBOutlet weak var repoDescLabel: UILabel!
    @IBOutlet weak var repoAvatarImageView: UIImageView!
    @IBOutlet weak var repoAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
