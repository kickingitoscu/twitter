//
//  TweetViewController.swift
//  Twitter
//
//  Created by Mariana Duarte on 9/20/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextview.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextview.text, success: {
                self.dismiss(animated: true, completion: nil)
                
            }, failure: { (Error) in
                print("Error \(Error)")
                self.dismiss(animated: true, completion: nil)
            })
        }else{
            print("Put text")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var tweetTextview: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextview.becomeFirstResponder()
        // Do any additional setup after loading the view.
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
