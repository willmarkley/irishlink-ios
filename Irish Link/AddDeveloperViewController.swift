//
//  AddDeveloperViewController.swift
//  Irish Link
//
//  Created by William Markley on 3/13/17.
//  Copyright © 2017 William Markley. All rights reserved.
//

import UIKit

class AddDeveloperViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var iosSwitch: UISwitch!
    @IBOutlet weak var androidSwitch: UISwitch!
    @IBOutlet weak var webSwitch: UISwitch!
    @IBOutlet weak var desktopSwitch: UISwitch!
    @IBOutlet weak var languagesTextField: UITextField!
    
    //MARK: Actions
    
    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {});
    }
    
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {});
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
