//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-10-05.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class User: NSObject { // include everything you think is in profile page from mobile app!!
    var id: Int
    var id_str: String?
    var name: String?
    var screen_name: String?
    // var user_description: String? // had to change name as it interferes with NSObject description
    var followers_count: Int
    var friends_count: Int // Following_count
    var created_at: String?
    var profile_banner_url: String?
    var profile_image_url: String?
    private static var _current: User?
    
    var dictionary: [String: Any]?
    
    init(dictionary: [String : Any]) {
        // super.init()
        self.dictionary = dictionary
        id = dictionary["id"] as! Int
        id_str = dictionary["id_str"] as? String
        name = dictionary["name"] as? String
        screen_name = dictionary["screen_name"] as? String
        // user_description = dictionary["user_description"] as? String
        followers_count = dictionary["followers_count"] as! Int
        friends_count = dictionary["friends_count"] as! Int
        created_at = dictionary["created_at"] as? String
        profile_banner_url = dictionary["profile_banner_url"] as? String
        profile_image_url = dictionary["profile_image_url"] as? String

        // super.init()
    }

    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
}
