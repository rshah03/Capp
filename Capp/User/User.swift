//
//  User.swift
//  Capp
//
//  Created by Ronak Shah on 10/10/17.
//  Copyright © 2017 Team6. All rights reserved.
//

import Foundation

class User {
    var email: String
    var password: String
    var favoriteShops: [Shop]!
    
    init(email: String, password: String, favoriteShops: [Shop]) {
        self.email = email
        self.password = password
        self.favoriteShops = favoriteShops
    }
    
    func getEmail() -> String {
        return email
    }
    
    func getPassword() -> String {
        return password
    }
    
    func getFavorites() -> [Shop] {
        return favoriteShops
    }
    
    func addToFavorites(shopToAdd: Shop) {
        //when calling this function, add via shopID
        var isRepeated = false
        for shop in favoriteShops {
            if shopToAdd.getShopID() == shop.getShopID() {
                isRepeated = true
                break;
            }
        }
        if !isRepeated {
            favoriteShops.append(shopToAdd)
        }
    }
    
    func removeFromFavorites(shopID: Int) {
        for (index,shop) in favoriteShops.enumerated() {
            if shop.shopID == shopID {
                favoriteShops.remove(at: index)
            }
        }
    }
    
}
