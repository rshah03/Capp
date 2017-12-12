//
//  ChangeNameViewController.swift
//  Capp
//
//  Created by Chuck Argyle on 12/11/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import Firebase

class ChangeNameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func changeName(_ sender: UIButton) {
        if (nameTextField.text == nil) {
            let alert = UIAlertController(title: "", message: "Please enter a name.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = nameTextField.text
            changeRequest?.commitChanges(completion: { (error) in
                if (error != nil) {
                    let alert = UIAlertController(title: "", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "", message: "Name successfully changed.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
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
