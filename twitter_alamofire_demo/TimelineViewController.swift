//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate {

    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        self.tableView.reloadData()
        fetchTweets()
    }

    func did(post: Tweet) {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchTweets()
    }
    
    func fetchTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                self.tweets = tweets!
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        // APIManager.shared.logout() //shared is static
        APIManager.logout() // logout is static
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("1")
        if segue.identifier == "detailedTweetSegue" {
            print("2")
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let tweet = tweets[indexPath.row]
                let detailedViewController = segue.destination as! DetailedViewController
                detailedViewController.tweet = tweet;
            }
        }
        else if segue.identifier == "composeTweetSegue" {
            print("3")
            let composeViewController = segue.destination as! ComposeViewController
            composeViewController.delegate = self;
            present(composeViewController, animated: true, completion: nil)
        } else {
            print(segue.identifier)
            print("4")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
