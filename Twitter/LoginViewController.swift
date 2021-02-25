//
//  LoginViewController.swift
//  Twitter
//
//  Created by Manny Reyes on 2/24/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

        
    @IBAction func onLoginButton(_ sender: Any) {
        // Do any additional setup after loading the view.
        //code to connect button here
        let myUrl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myUrl, success: {
            //wnt to go from login to home screen
            
            UserDefaults.standard.set(true, forKey: "userLoggedIn") //key is what we want the name of this value to be
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Unable to Login")
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //check the user is set to the specific key
        if UserDefaults.standard.bool(forKey: "userLoggedIn")==true{
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
