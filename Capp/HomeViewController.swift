//
//  FirstViewController.swift
//  Capp
//
//  Created by Ronak Shah on 10/5/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import ChameleonFramework

class FirstViewController: UIViewController {

    var gradientLayer: CAGradientLayer!
    @IBOutlet weak var leadingC: NSLayoutConstraint!
    @IBOutlet weak var trailingC: NSLayoutConstraint!
    @IBOutlet weak var slidingView: UIView!
    @IBOutlet weak var SearchPanel: UIView!
    @IBAction func settingsButton(_ sender: Any) {
        performSegue(withIdentifier: "ToSettingsView", sender: self)
    }
    
    
    @IBOutlet weak var Pet: UISwitch!
    @IBOutlet weak var Ambiance: UISwitch!
    @IBOutlet weak var Study: UISwitch!
    @IBOutlet weak var Social: UISwitch!
    

    var menuIsVisible = false
    var searchQuery : String?
    var tag = Set<String>()
    
    @IBAction func Search(_ sender: UIButton) {
        self.tag.removeAll()
        self.searchQuery = "coffee and tea"
        if Pet.isOn {
            tag.insert("Pet Friendly")
        }
        if Ambiance.isOn{
            tag.insert("Ambiance")
        }
        if Study.isOn{
            tag.insert("Study")
        }
        if Social.isOn{
            tag.insert("Social")
        }
        self.performSegue(withIdentifier: "ToMapView", sender: self)
        
    }
    @IBAction func menuToggler(_ sender: Any) {
        if !menuIsVisible {
            leadingC.constant = 150
            trailingC.constant = -150
            menuIsVisible = true
        } else {
            leadingC.constant = 0
            trailingC.constant = 0
            menuIsVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("Animation complete")
        }
    }
    
    
    @IBOutlet weak var settings: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradient()
        SearchPanel.backgroundColor = UIColor(white:1, alpha: 0.3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createGradient() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.flatSandDark.cgColor, UIColor.flatGreen.cgColor]
        slidingView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "ToMapView"){
            let dvc = segue.destination as! MapViewController
            dvc.searchQuery = self.searchQuery!
            dvc.tags = self.tag
        }
    }

}

