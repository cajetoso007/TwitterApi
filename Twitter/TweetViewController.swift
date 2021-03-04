//
//  TweetViewController.swift
//  Twitter
//
//  Created by Manny Reyes on 3/3/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBAction func cancel(_ sender: Any) {
        // dewaling with cancel becasue it si the easiest
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Tweet(_ sender: Any) {
        //controller is setup
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success:{ self.dismiss(animated: true, completion: nil)}, failure: {(error)in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }else{
            //if you knwo it's empty. type in some text
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
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
