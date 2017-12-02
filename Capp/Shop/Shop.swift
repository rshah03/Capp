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
    var shopTypeInit: String
    var shopID: Int
    var shopName: String
    var shopReviews: [Review]
    var openTime: String
    var closeTime: String
    var tags: [String]?
    
    
    init(shopTypeInit: String, shopID: Int, shopName: String, openTime: String, closeTime: String, tags: [String]?) {
        self.shopID = shopID
        self.shopName = shopName
        self.openTime = openTime
        self.closeTime = closeTime
        self.shopTypeInit = shopTypeInit
        self.shopReviews = [Review]()
       self.shopType = shopTypeInit.lowercased()
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

    func getShopID() -> Int {
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
    
    func getReviews() -> [Review] {
        var reviewAggregate = [Review]()
        for review in shopReviews {
            reviewAggregate.append(review)
        }
        
        return reviewAggregate
    }
    
    func importShopList() -> [Shop]{
        if let path = Bundle.main.path(forResource: "shopList", ofType: "json"){
            do{
                let jsonData = try String(contentsOfFile: path, encoding: .utf8)
                let decoder = JSONDecoder()
                let shopList = try! decoder.decode([Shop].self, from: jsonData.data(using: .utf8)!)
                return shopList
            }
            catch {
                print("\(error)")
            }
        }
        return [Shop]()
    }
    
    //Delete review function may not be necessary. Can be removed arbitrarily by admins.
    
}
