//
//  ViewController.swift
//  Irish Link
//
//  Created by William Markley on 3/2/17.
//  Copyright © 2017 William Markley. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let blueColor = UIColor(red: 86/255.0, green: 255/255.0, blue: 165/255.0, alpha: 1.0)
        view.backgroundColor = blueColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

