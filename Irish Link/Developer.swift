//
//  Developer.swift
//  Irish Link
//
//  Created by William Markley on 3/13/17.
//  Copyright © 2017 William Markley. All rights reserved.
//

import UIKit

class Developer {
    
    //MARK: Properties
    
    var name: String
    var email: String
    var apps: String
    var languages: String
    
    //MARK: Initialization
    
    init(name: String, email: String, iOS: Bool, android: Bool, web: Bool, desktop: Bool, languages: String){
        self.name = name
        self.email = email
        self.apps = ""
        if iOS {
            self.apps += "iOS  "
        }
        if android {
            self.apps += "Android  "
        }
        if web {
            self.apps += "Web  "
        }
        if desktop {
            self.apps += "Desktop "
        }
        self.languages = languages
    }
    
}
