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
    //var shopReviews is an arrar of type Reviews -- create a class called Reviews to store ther ratings and user reviews
    var businessHours: String
    
    
    init(shopTypeInit: String, shopID: Int, shopName: String, businessHours: String) {
        self.shopID = shopID
        self.shopName = shopName
        self.businessHours = businessHours //call parseBusinessHours(businessHours) here once function is complete
        self.shopTypeInit = shopTypeInit
    }
    
    //input will be in format: "xxxx-yyyy
//    func parseBusinessHours(rawHours: String) -> String {
//
//    }
    
    func getCategory() -> Category {
        return shopType!
    }
    
    func setCategory() {
        if shopTypeInit.lowercased() == "coffee" {
            shopType = Category.coffeeShop
        }
        else if shopTypeInit.lowercased() == "tea" {
            shopType = Category.teaShop
        }
        else if shopTypeInit.lowercased() == "teaAndCoffee" {
            shopType = Category.coffeeAndTeaShop
        }
    }
    
    func getShopID() -> Int {
        return shopID
    }
    
    func getShopName() -> String {
        return shopName
    }
    
    func getBusinessHours() -> String {
        return businessHours
    }
}
