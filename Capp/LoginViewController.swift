//
//  LoginViewController.swift
//  Capp
//
//  Created by Ronak Shah on 10/5/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class LoginViewController: UIViewController {
    
    var gradientLayer: CAGradientLayer!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var LoginPanel: UIView!
    
    @IBAction func loginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error == nil {
                self.performSegue(withIdentifier: "loginToMain", sender: self)
            } else {
                let alertController = UIAlertController(title: "Login Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
    @IBAction func registerButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToRegister", sender: sender)
    }
    
    @IBAction func forgotPAssword(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: emailField.text!) {error in
            if error != nil {
                let alertController = UIAlertController(title: "Password Reset Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                let successMessage = "An email has been sent to you with details on recovering your password."
                let alertController = UIAlertController(title: "Password Reset Sent", message: successMessage, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradient()
        LoginPanel.backgroundColor = UIColor(white:1, alpha: 0.3)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    func createGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.flatBlue.cgColor, UIColor.flatSkyBlue.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}
