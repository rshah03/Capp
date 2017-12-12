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
    var oneshop:Shop?
    var shops = [Shop]()
    var tags:String = "["
    
    
    @IBOutlet weak var ShopName: UILabel!
    @IBOutlet weak var ShopDetails: UIView!
    @IBOutlet weak var Reviews: UIView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var closeTimeLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShopDetails.backgroundColor = UIColor(white: 1, alpha: 0.3)
        self.view.backgroundColor = GradientColor(.topToBottom, frame: self.view.frame, colors: [UIColor.flatGreen, UIColor.flatSandDark])
        self.shops = importShopList()
        self.ShopName.text = self.matchingItem?.name
        if let shop = getshopfromlist(name: (self.matchingItem?.name)!){
            self.addressLabel.text = parseAddress(selectedItem: (self.matchingItem?.placemark)!)
            self.openTimeLabel.text = "Opens: " + (shop.openTime)
            self.closeTimeLabel.text = "Closes: " + (shop.closeTime)
            self.phoneNumLabel.text = (self.matchingItem?.phoneNumber)!
            shop.addReview(review: Review(r: "Lorem", rating: 3))
            self.oneshop=shop
            for tag in shop.getTags() {
                if tag == shop.getTags()[shop.getTags().count-1] {
                    tags += tag + "]"
                }
                else {
                    tags += tag + ", "
                }
            }
            self.tagsLabel.text = tags
        }
        

        
//        for review in (self.shop?.getReviews())! {
//
//        }
//        print(self.shop?.getReviews())
        

        
    }
    @IBAction func Reviews(_ sender: Any) {
        if self.oneshop != nil {
            self.performSegue(withIdentifier: "ToReviwTable", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "ToReviwTable"){
            let dvc=segue.destination as! ReviewTableController
            dvc.shop = self.oneshop
            
        }
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
