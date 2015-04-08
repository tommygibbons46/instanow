

//////////////////////////////////////////////////////// TOMMY CODE FROM YOUTUBE VIDEO ////////////////////////////

import UIKit
import Parse
import ParseUI
class LogInParse: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate
{
    var logInViewController: PFLogInViewController! = PFLogInViewController()
    var signUpViewController: PFSignUpViewController! = PFSignUpViewController()

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        println(PFUser.currentUser())
        if (PFUser.currentUser() == nil)
        {
            PFLogInFields.LogInButton | PFLogInFields.SignUpButton | PFLogInFields.PasswordForgotten | PFLogInFields.DismissButton

            var logInLogoTitle = UILabel()
            logInLogoTitle.text = "Log In"
            self.logInViewController.logInView.logo = logInLogoTitle
            self.logInViewController.delegate = self
            var signUpLogoTitle = UILabel()
            signUpLogoTitle.text = "Sign Up"
            self.signUpViewController.signUpView.logo = signUpLogoTitle
            self.signUpViewController.delegate = self
            self.logInViewController.signUpController = self.signUpViewController
        }
    }

    ////////////////////////////////////////// DELEGATE METHODS FOR LOGIN AND SIGNUP ////////////////////////////

    func logInViewController(logInController: PFLogInViewController!, shouldBeginLogInWithUsername username: String!, password: String!) -> Bool
    {
        if !username.isEmpty || !password.isEmpty
        {
            return true
        } else
        {
            return false
        }
    }

    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func logInViewController(logInController: PFLogInViewController!, didFailToLogInWithError error: NSError!)
    {
        println("Failed to login")
    }



    // PARSE SIGN UP
    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        println(PFUser.currentUser())
    }

    func signUpViewController(signUpController: PFSignUpViewController!, didFailToSignUpWithError error: NSError!)
    {
        println("Failed to sign up")
    }

    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController!)
    {
        println("User dismissed sign up")
    }


    // ACTIONS
    @IBAction func simpleAction(sender: AnyObject)
    {
        self.presentViewController(self.logInViewController, animated: true, completion: nil)
    }

    @IBAction func logOut(sender: AnyObject)
    {
        PFUser.logOut()
        println(PFUser.currentUser())
    }


    ////////////////////////////////////////// DELEGATE METHODS ENDED /////////////////////////////////////
    
}





























//////////////////////////////////////////// OLD WORKING CODE FROM RICHES VIDEO //////////////////////////////////////////
//
//import UIKit
//class LogInViewController: UIViewController, UITextFieldDelegate
//{
//    @IBOutlet weak var emailAddress: UITextField!
//    @IBOutlet weak var password: UITextField!
//    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        activityIndicator.hidden = true
//        activityIndicator.hidesWhenStopped = true
//        password.secureTextEntry = true
//        password.delegate = self
//        emailAddress.delegate = self
//    }
//
//    func textFieldShouldReturn(textField: UITextField) -> Bool
//    {
//        self.view.endEditing(true)
//        return false
//    }
//
//    @IBAction func signUp(sender: UIButton)
//    {
//        let user = PFUser()
//        user.username = emailAddress.text
//        user.password = password.text
//        user.email = emailAddress.text
//
//        user.signUpInBackgroundWithBlock { (returnedResult, returnedError) -> Void in
//            if returnedError == nil
//            {
//                self.dismissViewControllerAnimated(true, completion: nil)
//            }
//            else
//            {
//                self.showAlert("There was an error with your sign up", error: returnedError)
//            }
//        }
//    }
//
//    @IBAction func signIn(sender: UIButton)
//    {
//        PFUser.logInWithUsernameInBackground(emailAddress.text, password: password.text) { (returnedUser, returnedError) -> Void in
//            if returnedError == nil
//            {
//                self.dismissViewControllerAnimated(true, completion: nil)
//            }
//            else
//            {
//                self.showAlert("There was an error with your login", error: returnedError)
//            }
//        }
//    }
//
//    func showAlert(message: String, error:NSError)
//    {
//        let alert = UIAlertController(title: message, message: error.localizedDescription, preferredStyle: .Alert)
//        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
//        alert.addAction(okAction)
//        presentViewController(alert, animated: true, completion: nil)
//    }
//}




