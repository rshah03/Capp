//
//  ChangeUsernameViewController.swift
//  Capp
//
//  Created by Chuck Argyle on 11/13/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import Firebase

class ChangeUsernameViewController: UIViewController {

    @IBOutlet weak var newUsername: UITextField!
    @IBOutlet weak var confirmUsername: UITextField!
    
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

    @IBAction func changeButton(_ sender: UIButton) {
        //TODO: Add implementation for changing username...
        
        // Perform basic validation...
        if (newUsername.text! != confirmUsername.text!) {
            let alert = UIAlertController(title: "", message: "Usernames do not match", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if (confirmUsername.text! == "") {
            let alert = UIAlertController(title: "", message: "Username does not match", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let user = Auth.auth().currentUser
            user?.updateEmail(to: newUsername.text!, completion: { (error) in
                if (error != nil) {
                    let alert = UIAlertController(title: "", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "", message: "Username successfully changed.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
}
