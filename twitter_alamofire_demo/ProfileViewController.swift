//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Kyle Mamiit (New) on 11/12/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    @IBOutlet weak var numFollowingLabel: UILabel!
    
    @IBOutlet weak var numFollowersLabel: UILabel!
    
    @IBOutlet weak var numTweetsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(User.current)
        fullNameLabel.text = User.current?.name
        twitterHandleLabel.text = User.current?.screen_name
        let followingCount = User.current?.friends_count as! Int
        numFollowingLabel.text = String(followingCount)
        let followerCount = User.current?.followers_count as! Int
        numFollowersLabel.text = String(followerCount)
        // numTweetsLabel.text = User.current.
    }
    
    @IBAction func didCancel(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
