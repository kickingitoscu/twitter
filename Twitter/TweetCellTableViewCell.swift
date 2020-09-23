//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Mariana Duarte on 9/15/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBAction func favoriteTweet(_ sender: Any) {
        let tobeFav = !favorite
        if(tobeFav) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavor(true)
            }, failure: { (Error) in
                print("doesn't work \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                 self.setFavor(false)
            }, failure: { (Error) in
                print("doesn't work unfavorite \(Error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
            
        }, failure: { (Error) in
            print("doesn't work retweet \(Error)")
        })
        
        
    }
    
    var favorite:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    func setFavor(_ isFavorite:Bool){
        favorite = isFavorite
        
        if(favorite) {
            favButton.setImage(UIImage( named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage( named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        
        if(isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage( named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
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
