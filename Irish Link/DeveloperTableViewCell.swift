//
//  DeveloperTableViewCell.swift
//  Irish Link
//
//  Created by William Markley on 3/2/17.
//  Copyright © 2017 William Markley. All rights reserved.
//

import UIKit

class DeveloperTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var appsLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    
    //MARK: Actions
    
    @IBAction func emailButton(_ sender: UIButton) {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
