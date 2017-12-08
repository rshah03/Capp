//
//  DetailViewController.swift
//  Capp
//
//  Created by Ronak Shah on 12/8/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import ChameleonFramework

class DetailViewController: UIViewController {

    @IBOutlet weak var ShopDetails: UIView!
    @IBOutlet weak var Reviews: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var closeTimeLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBAction func navigateButton(_ sender: UIButton) {
        
    }
    @IBOutlet weak var reviewsScroll: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShopDetails.backgroundColor = UIColor(white: 1, alpha: 0.3)
        Reviews.backgroundColor = UIColor(white: 1, alpha: 0.3)
        self.view.backgroundColor = GradientColor(.topToBottom, frame: self.view.frame, colors: [UIColor.flatGreen, UIColor.flatSandDark])
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
