//
//  IdeaTableViewController.swift
//  Irish Link
//
//  Created by William Markley on 3/14/17.
//  Copyright © 2017 William Markley. All rights reserved.
//

import UIKit

class IdeaTableViewController: UITableViewController, GIDSignInUIDelegate {
    
    //MARK: Properties
    
    var ideas = [Idea]()
    var request = URLRequest(url: URL(string: "http://54.82.225.169:8080/ideas")!)
    
    //MARK: Actions

    @IBAction func signOutBarButton(_ sender: UIBarButtonItem) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    //MARK: Private Functions
    
    private func loadSampleIdeas() {
        let idea1 = Idea(name: "William", email: "wmarkley@nd.edu", iOS: true, android: true, web: false, desktop: false, description: "App to connect ideators")
        let idea2 = Idea(name: "Catherine", email: "wmarkley@nd.edu", iOS: true, android: true, web: true, desktop: false, description: "Cottage App")
        let idea3 = Idea(name: "Dad", email: "wmarkley@nd.edu", iOS: false, android: true, web: false, desktop: true, description: "Sunset App")
        
        ideas += [idea1, idea2, idea3]
    }
    
    private func loadApiIdeas() {
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var ideaEntries = [Idea]()
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error)
            }
            
            let responseData = data
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: responseData!, options: []) as? NSArray
                for jsonObject in jsonData!{
                    if let object = jsonObject as? NSDictionary{
                        let entryName        = object["name"] as? String
                        let entryEmail       = object["email"] as? String
                        let entryiOS         = object["iosapp"] as? NSNumber
                        let entryAndroid     = object["androidapp"] as? NSNumber
                        let entryWeb         = object["webapp"] as? NSNumber
                        let entryDesktop     = object["desktopapp"] as? NSNumber
                        let entryDescription = object["description"] as? String
                        
                        let boolEntryiOS     = Bool(entryiOS!)
                        let boolEntryAndroid = Bool(entryAndroid!)
                        let boolEntryWeb     = Bool(entryWeb!)
                        let boolEntryDesktop = Bool(entryDesktop!)
                        
                        let ideaEntry = Idea(name: entryName!, email: entryEmail!, iOS: boolEntryiOS, android: boolEntryAndroid, web: boolEntryWeb, desktop: boolEntryDesktop, description: entryDescription!)
                        
                        ideaEntries.append(ideaEntry)
                    }
                }
            }catch {
                fatalError("error in JSONSerialization")
            }
            self.ideas = ideaEntries
            self.tableView.reloadData()  // shows the data in table since the completion handler is asynchronous
        })
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadApiIdeas()
        //loadSampleIdeas()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadApiIdeas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "IdeaTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IdeaTableViewCell else {
            fatalError("The dequened cell is not an instance of IdeaTableViewCell")
        }
        
        let idea = ideas[indexPath.row]
        
        cell.nameLabel.text = idea.name
        cell.appsLabel.text = idea.apps
        cell.descriptionLabel.text = idea.description
        cell.buttonLabel.setTitle(idea.email, for: .normal)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var remove = true
        if editingStyle == .delete {
            // Delete the row from the data source
            let inputName    = ideas[indexPath.row].name
            let inputEmail   = ideas[indexPath.row].email
            var inputIos     = 0
            var inputAndroid = 0
            var inputWeb     = 0
            var inputDesktop = 0
            let inputDescription = ideas[indexPath.row].description
            let searchStr    = ideas[indexPath.row].apps
            
            if searchStr.range(of:"iOS") != nil{
                inputIos = 1
            }
            if searchStr.range(of:"Android") != nil{
                inputAndroid = 1
            }
            if searchStr.range(of:"Web") != nil{
                inputWeb = 1
            }
            if searchStr.range(of:"Desktop") != nil{
                inputDesktop = 1
            }
            
            let tok = UserDefaults.standard.value(forKey: "user_auth_idToken")!
            
            let data = ["token": tok, "name": inputName, "email": inputEmail, "iosapp": inputIos, "androidapp": inputAndroid, "webapp": inputWeb, "desktopapp": inputDesktop, "description": inputDescription] as [String:Any]
            let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            
            request.httpMethod = "DELETE"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error)
                }
                let d = String(data: data!, encoding: .utf8)
                if d == "The document with the given token was NOT removed"{
                    print("ENTER")
                    remove = false
                }
                if remove {
                    self.ideas.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            })
            task.resume()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
