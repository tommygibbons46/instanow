//
//  LogInViewController.swift
//  ParseStarterProject
//
//  Created by Tommy Gibbons on 4/6/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit


class LogInViewController: UIViewController, UITextFieldDelegate {

    //connect to storyboard and name accordingly
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidden = true
        activityIndicator.hidesWhenStopped = true
        password.secureTextEntry = true

        password.delegate = self
        emailAddress.delegate = self

    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func signUp(sender: UIButton)
    {
        let user = PFUser()
        user.username = emailAddress.text
        user.password = password.text
        user.email = emailAddress.text

        user.signUpInBackgroundWithBlock { (returnedResult, returnedError) -> Void in
            if returnedError == nil
            {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else
            {
                self.showAlert("There was an error with your sign up", error: returnedError)
            }
        }
    }



    func showAlert(message: String, error:NSError)
    {
        let alert = UIAlertController(title: message, message: error.localizedDescription, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }


    @IBAction func signIn(sender: UIButton)
    {
        PFUser.logInWithUsernameInBackground(emailAddress.text, password: password.text) { (returnedUser, returnedError) -> Void in
            if returnedError == nil
            {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else
            {
                self.showAlert("There was an error with your login", error: returnedError)
            }
        }
    }


    //connect to storyboard and name as indicated
    @IBAction func signMeUp(sender: AnyObject)
    {
        if password.text != "" && emailAddress.text != "" {
            processSignUp()
        } else {
            // Empty, Notify user
            self.emailAddress.placeholder = "Required"
            self.password.placeholder = "Required"

        }
        resignFirstResponder()
    }



    func processSignIn ()

    {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()

        var userEmailAddress = emailAddress.text
        userEmailAddress = userEmailAddress.lowercaseString

        var userPassword = password.text

        PFUser.logInWithUsernameInBackground(userEmailAddress, password: userPassword) { (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    println("success 2")
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
                    println("success")
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

    @IBAction func signMeIn(sender: AnyObject)
    {
        if password.text != "" && emailAddress.text != "" {
            processSignIn()
        } else {
            // Empty, Notify user
            self.emailAddress.placeholder = "Required"
            self.password.placeholder = "Required"
        }

        resignFirstResponder()
        
    }







}
