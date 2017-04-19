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
    
    var developers = [Developer]()
    var request = URLRequest(url: URL(string: "http://54.82.225.169:8080/developers")!)
    
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
        let inputLanguages = languagesTextField.text
        
        let tok = UserDefaults.standard.value(forKey: "user_auth_idToken")!
        
        let data = ["token": tok, "name": inputName!, "email": inputEmail!, "iosapp": inputIos, "androidapp": inputAndroid, "webapp": inputWeb, "desktopapp": inputDesktop, "languages": inputLanguages!] as [String:Any]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)

        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }
        })
        task.resume()
        
        self.dismiss(animated: true, completion: {});
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let color = UIColor(red: 222/255.0, green: 200/255.0, blue: 171/255.0, alpha: 1.0)
        view.backgroundColor = color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
