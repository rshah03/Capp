//
//  ProfileViewController.swift
//  Capp
//
//  Created by Chuck Argyle on 12/5/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    var logo : URL = (URL(string: "www.google.com"))!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // <Q> Test code...
        let checkUser = Auth.auth().currentUser
        
        if (checkUser?.displayName == nil) {
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = "Chuck Norris"
            changeRequest?.commitChanges(completion: nil)
        }

        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Chuck_Norris_May_2015.jpg/220px-Chuck_Norris_May_2015.jpg")
        changeRequest?.commitChanges(completion: nil)
        
        
        // </Q> End of test code...
}
    
    override func viewDidAppear(_ animated: Bool) {
        let user = Auth.auth().currentUser
        self.emailLabel.text = user?.email
        self.nameLabel.text = user?.displayName
        logo = (user?.photoURL)!
        print("The URL is: " + logo.absoluteString)
        
        URLSession.shared.dataTask(with: logo, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.pictureImageView.contentMode = .scaleAspectFit
                self.pictureImageView.image = UIImage(data: data!)
            }
        }).resume()
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
