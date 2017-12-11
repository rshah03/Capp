//
//  DetailViewController.swift
//  Capp
//
//  Created by Ronak Shah on 12/8/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import UIKit
import MapKit
import ChameleonFramework
import GooglePlaces

class DetailViewController: UIViewController {
    var matchingItem:MKMapItem?
    var shop:Shop?
    var shops = [Shop]()
    
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    @IBOutlet weak var ShopName: UILabel!
    @IBOutlet weak var ShopDetails: UIView!
    @IBOutlet weak var Reviews: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var closeTimeLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShopDetails.backgroundColor = UIColor(white: 1, alpha: 0.3)
        Reviews.backgroundColor = UIColor(white: 1, alpha: 0.3)
        self.view.backgroundColor = GradientColor(.topToBottom, frame: self.view.frame, colors: [UIColor.flatGreen, UIColor.flatSandDark])
        self.shops = importShopList()
        self.shop = getshopfromlist(name: (self.matchingItem?.name)!)
        self.ShopName.text = self.matchingItem?.name
        self.addressLabel.text = parseAddress(selectedItem: (self.matchingItem?.placemark)!)
        self.openTimeLabel.text = "Opens: " + (self.shop?.openTime)!
        self.closeTimeLabel.text = "Closes: " + (self.shop?.closeTime)!
        self.phoneNumLabel.text = (self.matchingItem?.phoneNumber)!
        self.shop?.addReview(review: Review(r: "Lorem", rating: 3))

        

        
//        for review in (self.shop?.getReviews())! {
//
//        }
//        print(self.shop?.getReviews())
        

        
    }
    @IBAction func Reviews(_ sender: Any) {
        self.performSegue(withIdentifier: "ToReviwTable", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "ToReviwTable"){
            let dvc=segue.destination as! ReviewTableController
            dvc.shop = self.shop
            
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return (self.shop?.getReviews().count)!
        return self.animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("@#@#YT@*&#(^@#*&@^#&*^@#&*@&#*(^@#&*@(^#@&#*()))")
        """
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        //let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        cell.textLabel?.text = self.shop?.getReviews()[0]
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", cell.textLabel!)
        return cell
"""
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.animals[indexPath.row]
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func navigation(_ sender: UIButton) {
        let mapItem = MKMapItem(placemark: (matchingItem?.placemark)!)
        mapItem.name = matchingItem?.name
        mapItem.openInMaps(launchOptions: nil)
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? "," : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let thirdSpace = (selectedItem.administrativeArea != nil && selectedItem.postalCode != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? "",
            thirdSpace,
            // zip code
            selectedItem.postalCode ?? ""
        )
        return addressLine
    }
    func importShopList() -> [Shop]{
        let path = Bundle.main.path(forResource: "shopList", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let jsonData = try! Data(contentsOf: url)
        do {
            let shopList = try JSONDecoder().decode([Shop].self, from: jsonData)
            print("IMPORT SHOPLIST: SUCCESS\n\n")
            return shopList
        }
        catch{
            print("\(error)")
        }
        print("IMPORT SHOPLIST: FAIL\n")
        return [Shop]()
    }
    func getshopfromlist(name: String) -> Shop? {
        for shop in shops{
            //print(intersection)
            if (name.range(of: shop.shopName) != nil ){
                print("match found")
                return shop
            }
        }
        return nil
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
