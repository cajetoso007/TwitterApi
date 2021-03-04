//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Manny Reyes on 2/24/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    //store on local container
    //var means it can change
    var tweetArray = [NSDictionary]() //start with empty dictionary
    var numberOfTweets: Int!
    
    ///add a refresh control
    let myRefreshControl = UIRefreshControl()
    
    
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        //extract the user first
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        
        
        cell.userNameLabel.text = user["name"] as? String//the key is name
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        //will not set the image
        //setting the image now in Xcode
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)//(tweetArray[indexPath.row]["retweeted"] as! Bool
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTweets()
        
        //numberOfTweets = 20
       myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        self.tableView.refreshControl = myRefreshControl
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
        //self.tweetArray.refreshControl = myRefreshControl
        //self.tweetArray.rowHeight = UITableView.automaticDimension
        //need to create a user default to have the app remember we're logged in**/
    }
    
    
    
    
    @objc func loadTweets(){
        
        //when we firt load
        numberOfTweets = 20
        
        
        //call the API
        let myurl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count":numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myurl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            //clean up the array every single time
            self.tweetArray.removeAll()
            
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
            //once we're done populating
            self.tableView.reloadData()
            
            //once done updating the table
            //set to end refreshing
            self.myRefreshControl.endRefreshing() //will get rid of refresing circle
            
        }, failure: {(Error) in
            print("Could not retrieve the tweets")
        })
    }

    func loadMoreTweets(){
        //this will get the number of tweets
        //url will be the same
        //called anytime user gets to end of tweets
        let myurl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        numberOfTweets = numberOfTweets + 20 //adds 20 to number of tweets
        
        let myParams = ["count" : numberOfTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myurl, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
            
            //clean up the array every single time
            self.tweetArray.removeAll()
            
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
            //once we're done populating
            self.tableView.reloadData()
            
            
        }, failure: {(Error) in
            print("Could not retrieve the tweets")
        })
        
        
        
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
      }
    
    
    
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //displays 5 rows
        return tweetArray.count //returning the number of tweets in the array
    }

    
}
