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
    var favoriteShops: [String]! //This will be optional and of type Shop when the Coffee/Tea shop class is created
    
    init(email: String, password: String, favoriteShops: [String]) {
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
    
    func getFavorites() -> [String] {
        return favoriteShops
    }
    
    func addToFavorites(shopID: Int) {
        //get shopName from shopID
        favoriteShops.append("Fetch shop name based on ID here and insert name here")
    }
    
    func removeFromFavorites(shopID: Int) {
        //for (index, shop) in favoriteShops.enumerated() {
            //if there is a shop in the favorites with an ID matching the parameter:
            //favoriteShops.remove(at: index)
            //break
        //}
    }
    
}
