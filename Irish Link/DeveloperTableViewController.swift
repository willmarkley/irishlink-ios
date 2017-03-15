//
//  DeveloperTableViewController.swift
//  Irish Link
//
//  Created by William Markley on 3/12/17.
//  Copyright © 2017 William Markley. All rights reserved.
//

import UIKit

class DeveloperTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var developers = [Developer]()
    var request = URLRequest(url: URL(string: "http://54.82.225.169:8080/developers")!)
    
    //MARK: Private Functions
    
    private func loadSampleDevelopers() {
        let developer1 = Developer(name: "William", email: "wmarkley@nd.edu", iOS: true, android: false, web: true, desktop: true, languages: "C++")
        let developer2 = Developer(name: "Claire", email: "wmarkley@nd.edu", iOS: true, android: true, web: false, desktop: true, languages: "Java")
        let developer3 = Developer(name: "Catherine", email: "wmarkley@nd.edu", iOS: false, android: false, web: true, desktop: false, languages: "Python")
        
        developers += [developer1, developer2, developer3]
    }
    
    private func loadApiDevelopers() {
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var developerEntries = [Developer]()

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error)
            }
            
            let responseData = data
            
            do{
                let jsonData = try JSONSerialization.jsonObject(with: responseData!, options: []) as? NSArray
                for jsonObject in jsonData!{
                    if let object = jsonObject as? NSDictionary{
                        let entryName      = object["name"] as? String
                        let entryEmail     = object["email"] as? String
                        let entryiOS       = object["iosapp"] as? NSNumber
                        let entryAndroid   = object["androidapp"] as? NSNumber
                        let entryWeb       = object["webapp"] as? NSNumber
                        let entryDesktop   = object["desktopapp"] as? NSNumber
                        let entryLanguages = object["languages"] as? String
                        
                        let boolEntryiOS     = Bool(entryiOS!)
                        let boolEntryAndroid = Bool(entryAndroid!)
                        let boolEntryWeb     = Bool(entryWeb!)
                        let boolEntryDesktop = Bool(entryDesktop!)
                        
                        let developerEntry = Developer(name: entryName!, email: entryEmail!, iOS: boolEntryiOS, android: boolEntryAndroid, web: boolEntryWeb, desktop: boolEntryDesktop, languages: entryLanguages!)
                        
                        developerEntries.append(developerEntry)
                    }
                }
            }catch {
                fatalError("error in JSONSerialization")
            }
            self.developers = developerEntries
            self.tableView.reloadData()  // shows the data in table since the completion handler is asynchronous
        })
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadApiDevelopers()
        //loadSampleDevelopers()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadApiDevelopers()
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
        return developers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DeveloperTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DeveloperTableViewCell else {
            fatalError("The dequened cell is not an instance of DeveloperTableViewCell")
        }

        let developer = developers[indexPath.row]
        
        cell.nameLabel.text = developer.name
        cell.appsLabel.text = developer.apps
        cell.languagesLabel.text = developer.languages
        cell.buttonLabel.setTitle(developer.email, for: .normal)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
