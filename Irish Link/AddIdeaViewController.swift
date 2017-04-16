//
//  AddIdeaViewController.swift
//  Irish Link
//
//  Created by William Markley on 3/13/17.
//  Copyright © 2017 William Markley. All rights reserved.
//

import UIKit

class AddIdeaViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var iosSwitch: UISwitch!
    @IBOutlet weak var androidSwitch: UISwitch!
    @IBOutlet weak var webSwitch: UISwitch!
    @IBOutlet weak var desktopSwitch: UISwitch!
    
    var ideas = [Idea]()
    var request = URLRequest(url: URL(string: "http://54.82.225.169:8080/ideas")!)
    
    //MARK: Actions

    @IBAction func cancelBarButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: {});
    }
    
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) {
        let inputName    = nameTextField.text
        let inputEmail   = emailTextField.text
        var inputIos     = 0
        var inputAndroid = 0
        var inputWeb     = 0
        var inputDesktop = 0
        if iosSwitch.isOn {
            inputIos = 1
        }
        if androidSwitch.isOn {
            inputAndroid = 1
        }
        if webSwitch.isOn {
            inputWeb = 1
        }
        if desktopSwitch.isOn {
            inputDesktop = 1
        }
        let inputDescription = descriptionTextField.text
        
        let tok = UserDefaults.standard.value(forKey: "user_auth_idToken")!
        
        let data = ["token": tok, "name": inputName!, "email": inputEmail!, "iosapp": inputIos, "androidapp": inputAndroid, "webapp": inputWeb, "desktopapp": inputDesktop, "description": inputDescription!] as [String:Any]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error)
            }
        })
        task.resume()
        
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
