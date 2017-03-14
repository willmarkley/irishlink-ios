//
//  IdeaTableViewCell.swift
//  Irish Link
//
//  Created by William Markley on 3/14/17.
//  Copyright © 2017 William Markley. All rights reserved.
//

import UIKit

class IdeaTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var appsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    
    //MARK: Actions
    
    @IBAction func emailButton(_ sender: UIButton) {
        let email = buttonLabel.titleLabel!.text!
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
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
