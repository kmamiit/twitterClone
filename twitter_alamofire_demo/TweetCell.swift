//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Kyle Mamiit (New) on 11/4/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var numRepliesLabel: UILabel!
    @IBOutlet weak var numRetweetsLabel: UILabel!
    @IBOutlet weak var numFavoritesLabel: UILabel!
    
    
    
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            numRepliesLabel.text = "0" // Need Premium or Enterprise tier
            numRetweetsLabel.text = String(describing: tweet.retweetCount)
            numFavoritesLabel.text = String(describing: tweet.favoriteCount)
        }
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
    
    
    func refreshData() {
        numFavoritesLabel.text = String(describing: tweet.favoriteCount)
        numRetweetsLabel.text = String(describing: tweet.retweetCount)
        
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
