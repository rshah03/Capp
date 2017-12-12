//
//  Shop.swift
//  Capp
//
//  Created by Ronak Shah on 10/11/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import Foundation

class Shop: Codable {
    enum Category{
        case coffeeShop
        case teaShop
        case coffeeAndTeaShop
    }
    var shopType: String
    var shopID: String
    var shopName: String
    var shopReviews: [Review]
    var openTime: String
    var closeTime: String
    var tags: [String]?
    
    
    init(shopType: String, shopID: String, shopReviews: [Review], shopName: String, openTime: String, closeTime: String, tags: [String]?) {
        self.shopID = shopID
        self.shopName = shopName
        self.openTime = openTime
        self.closeTime = closeTime
        self.shopReviews = shopReviews
        self.shopType = shopType.lowercased()
        if (tags != nil) {
            self.tags = tags
        }
    }

    func getCategory() -> Category {
        switch shopType {
        case "coffee":
            return Category.coffeeShop
        case "tea":
            return Category.teaShop
        default:
            return Category.coffeeAndTeaShop
        }
    }

    func getShopID() -> String {
        return shopID
    }
    
    func getShopName() -> String {
        return shopName
    }

    //    input will be in format: "xx:xx-yy:yy
    func getBusinessHours(open: String, close: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let openTimeArr = open.components(separatedBy: ":")
        let open_hour = openTimeArr[0]
        let open_mins = openTimeArr[1]
        
        let closeTimeArr = close.components(separatedBy: ":")
        let close_hour = closeTimeArr[0]
        let close_mins = closeTimeArr[1]
        
        let shopOpenTime = formatter.date(from: "\(open_hour):\(open_mins)")!
        let shopCloseTime = formatter.date(from: "\(close_hour):\(close_mins)")!
        
        return formatter.string(from: shopOpenTime) + " - " + formatter.string(from: shopCloseTime)
    }
    
    func getTags() -> [String] {
        return tags!
    }
    
    func searchTags(searchTag: String) -> Bool {
        for tag in tags! {
            if tag == searchTag {
                return true
            }
        }
        return false
    }
    
    
    func addReview(review: Review) {
//        shopReviews.append(review)
        shopReviews.insert(review, at: shopReviews.startIndex)
        //Maybe associate a reviwe with a unique user ID to prevent duplicates
    }
    
    func getReviews() -> [String] {
        var reviewAggregate: [String] = []
        for review in shopReviews {
            reviewAggregate.append(review.getReviewSummary())
        }
        
        return reviewAggregate
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
    
    //Delete review function may not be necessary. Can be removed arbitrarily by admins.
    
}
