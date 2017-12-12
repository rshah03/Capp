//
//  SettingsViewController.swift
//  Capp
//
//  Created by Chuck Argyle on 11/1/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    var settingsMenuItems = [SettingsMenuItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
        //_ = navigationController?.popViewController(animated: false)
        
        setupMenu()
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
        return settingsMenuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingsItem", for: indexPath) as? SettingsTableViewCell else {
            fatalError("The dequeued cell is not an instance of SettingsTableViewCell.")
        }

        // Configure the cell...
        let menuItem = self.settingsMenuItems[indexPath.row]
        cell.menuName.text = menuItem.label
        cell.toggleSwitch.isHidden = !menuItem.hasToggleSwitch

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = self.settingsMenuItems[indexPath.row]
        
        if (menuItem.hasSegue) {
            self.performSegue(withIdentifier: menuItem.segueId, sender: self)
        }
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
    
    
    //MARK: Private functions.
    func setupMenu() -> Void {
        let accountMenu = SettingsMenuItem(label : "Account", segueId : "AccountSegue")
        let profileMenu = SettingsMenuItem(label: "Profile", segueId: "ProfileSegue")
        let searchPreferenceMenu = SettingsMenuItem(label: "Search Preferences")
        //let notificationsMenu = SettingsMenuItem(label: "Notifications", hasToggleSwitch : true)
        //let locaationMenu = SettingsMenuItem(label: "Location", hasToggleSwitch : true)
        self.settingsMenuItems = [accountMenu, profileMenu, searchPreferenceMenu]
    }
    
    @IBAction func backToHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
