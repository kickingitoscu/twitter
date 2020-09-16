//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Mariana Duarte on 9/15/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {

    var tweetArr = [NSDictionary]()
    var numberOfTweet: Int!
    let myrefreshControl = UIRefreshControl()
    
    @objc func loadTweet(){
        numberOfTweet = 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = [ "count": numberOfTweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: params, success: { (tweets: [NSDictionary]) in
            
            self.tweetArr.removeAll()
            for  tweet in tweets {
                self.tweetArr.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myrefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("Couldn't retrive tweet!")
        })
    }
    
    func loadMore(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        numberOfTweet = numberOfTweet + 20
        let myparams = [ "count": numberOfTweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myparams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArr.removeAll()
            for  tweet in tweets {
                self.tweetArr.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myrefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("Couldn't load tweet!")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row + 1 == tweetArr.count {
            loadMore()
        }
    }
    
    @IBAction func Logout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        let user = tweetArr[indexPath.row]["user"] as! NSDictionary
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArr[indexPath.row]["text"] as? String
        let imgUrl = URL( string:(user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imgUrl!)
        
        if let imgData = data {
            cell.profileImgView.image = UIImage(data: imgData)
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        myrefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged )
        tableView.refreshControl = myrefreshControl
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArr.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
