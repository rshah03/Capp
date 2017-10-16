//
//  Shop.swift
//  Capp
//
//  Created by Ronak Shah on 10/11/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import Foundation

class Shop {
    enum Category {
        case coffeeShop
        case teaShop
        case coffeeAndTeaShop
    }
    var shopType: Category?
    var shopTypeInit: String
    var shopID: Int
    var shopName: String
    var shopReviews: [Review]!
    var openTime: String
    var closeTime: String
    
    
    init(shopTypeInit: String, shopID: Int, shopName: String, openTime: String, closeTime: String) {
        self.shopID = shopID
        self.shopName = shopName
        self.openTime = openTime
        self.closeTime = closeTime
        self.shopTypeInit = shopTypeInit
        switch shopTypeInit.lowercased() {
        case "coffee":
            shopType = Category.coffeeShop
        case "tea":
            shopType = Category.teaShop
        default:
            shopType = Category.coffeeAndTeaShop
        }
    }

    func getCategory() -> Category {
        return shopType!
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
    
    func addReview(review: Review) {
        shopReviews.append(review)
        //Maybe associate a reviwe with a unique user ID to prevent duplicates
    }
    
    //Delete review function may not be necessary. Cna be removed arbitrarily by admins.
    
}
