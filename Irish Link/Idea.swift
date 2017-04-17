//
//  Idea.swift
//  Irish Link
//
//  Created by William Markley on 3/14/17.
//  Copyright © 2017 William Markley. All rights reserved.
//

import UIKit

class Idea {
    
    //MARK: Properties
    
    var name: String
    var email: String
    var apps: String
    var description: String
    var mod: Int
    
    //MARK: Initialization
    
    init(name: String, email: String, iOS: Bool, android: Bool, web: Bool, desktop: Bool, description: String, mod: Int){
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
        self.description = description
        self.mod = mod
    }

}
