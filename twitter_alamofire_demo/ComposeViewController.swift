//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Kyle Mamiit (New) on 11/12/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: NSObjectProtocol {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {

//    @IBOutlet weak var composeTweetTextField: UITextField!

    @IBOutlet weak var composeTweetTextView: UITextView!
    
    @IBOutlet weak var charCountLabel: UILabel!
    
    
    weak var delegate: ComposeViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        composeTweetTextView.delegate = self

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        charCountLabel.text = "Characters Remaining: " +  String(characterLimit - newText.count)
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }
    
    
    @IBAction func didTapPost(_ sender: Any) { //onPost
        print("Just posted!")
        APIManager.shared.composeTweet(with: composeTweetTextView.text ?? "This is my tweet 😀") { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                NotificationCenter.default.post(name: NSNotification.Name("didTapPost"), object: nil)
                print("Compose Tweet Success!")
            }
        }
    }
    
    @IBAction func didCancel(_ sender: Any) {
        print("Just cancelled!")
//        APIManager.shared.composeTweet(with: "This is my tweet 😀") { (tweet, error) in
//            if let error = error {
//                print("Error composing Tweet: \(error.localizedDescription)")
//            } else if let tweet = tweet {
//                self.delegate?.did(post: tweet)
                NotificationCenter.default.post(name: NSNotification.Name("didCancel"), object: nil)
                print("Cancelled Tweet!")
//            }
//        }
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
