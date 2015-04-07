//
//  LogInViewController.swift
//  ParseStarterProject
//
//  Created by Tommy Gibbons on 4/6/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit


class LogInViewController: UIViewController {

    //connect to storyboard and name accordingly
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //connect to storyboard and name as indicated
    @IBAction func signUp(sender: AnyObject)
    {
        if password.text != "" && emailAddress.text != "" {
            processSignUp()
        } else {
            // Empty, Notify user
            self.emailAddress.text = "All Fields Required"
        }
    }

    @IBAction func signIn(sender: AnyObject)
    {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()

        var userEmailAddress = emailAddress.text
        userEmailAddress = userEmailAddress.lowercaseString

        var userPassword = password.text

        PFUser.logInWithUsernameInBackground(userEmailAddress, password: userPassword) { (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("signInToNavigation", sender: self)
                }
            } else {
                self.activityIndicator.stopAnimating()

//                if let message: AnyObject = error!.userInfo!["error"] {
//                    self.message.text = "\(message)"
//                }
            }
        }

    }

    func processSignUp ()
    {
        var userEmailAddress = emailAddress.text
        var userPassword = password.text

        //ensure username is lowercase
        userEmailAddress = userEmailAddress.lowercaseString

        //start activity indicator
        activityIndicator.hidden = false
        activityIndicator.startAnimating()

        //Create user

        var user = PFUser()
        user.username = userEmailAddress
        user.password = userPassword
        user.email = userEmailAddress

        user.signUpInBackgroundWithBlock { (succeeded: Bool! , error: NSError!) -> Void in
            if error == nil {
                dispatch_async(dispatch_get_main_queue()){
                    //make sure to properly name the segue identifier on storyboard
                    self.performSegueWithIdentifier("signInToNavigation", sender: self)
                }
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidden = true

//                if let message: AnyObject = error!.userInfo!["error"] {
//                self.message.text = "\(message)"
//                }
            }
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidden = true
        activityIndicator.hidesWhenStopped = true

    }



}
