//
//  DetailedViewController.swift
//  twitter_alamofire_demo
//
//  Created by Kyle Mamiit (New) on 11/12/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        if let tweet = tweet {
            fullNameLabel.text = tweet.user?.name;
            usernameLabel.text = tweet.user?.screen_name;
            tweetLabel.text = tweet.text;
            // profileImage.image =  tweet.user?.profile_image_url
        }
    }
    
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if tweet.retweeted! {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            postUnretweet()
        } else {
            tweet.retweeted = true
            tweet.retweetCount += 1
            postRetweet()
        }
        refreshData()
    }
    
    
    @IBAction func didTapFavorite(_ sender: Any) {
        // Update the local tweet model
        if tweet.favorited! {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            postUnfavorite()
        } else {
            tweet.favorited = true
            tweet.favoriteCount += 1
            postFavorite()
        }
        refreshData()
    }
    
    func refreshData() {
//        numFavoritesLabel.text = String(describing: tweet.favoriteCount)
//        numRetweetsLabel.text = String(describing: tweet.retweetCount)
        
        if tweet.favorited! {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControlState.normal)
        }
        
        if tweet.retweeted! {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
        }
        // Add replies later on if possible // Not available??
    }
    
    func postFavorite() {
        APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
    func postUnfavorite() {
        APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error unfavoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
    func postRetweet() {
        APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully retweeting the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
    func postUnretweet() {
        APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
            if let  error = error {
                print("Error unretweeted tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
            }
        }
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
