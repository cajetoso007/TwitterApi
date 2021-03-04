//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Manny Reyes on 3/4/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    var favorited:Bool = false
    var tweetId:Int = -1
    var reTweeted:Bool = false
    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named: " favor-icon-red"), for: UIControl.State.normal)
        } else{
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
            }
    }
   

    
    @IBAction func reTweet(_ sender: Any) {
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: {
            (error) in
            print("Error is retweeting: \(error)")
        })
    }
    @IBAction func favTweet(_ sender: Any) {
        let favorite = !favorited
        
        if(favorite){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: {
                (error) in
                print("favorite unsuccessful \(error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: {
                (error) in
                print("unfavorited unsuccessful")
            })
        }
    }
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var reTweet: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted){
            reTweet.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            reTweet.isEnabled = false
        }else{
            reTweet.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            reTweet.isEnabled = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
