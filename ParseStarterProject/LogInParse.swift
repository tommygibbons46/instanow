////////////////////////////////////////// CODE FROM RICHES VIDEO //////////////////////////////////////////

import UIKit
class LogInViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        activityIndicator.hidden = true
        activityIndicator.hidesWhenStopped = true
        password.secureTextEntry = true
        password.delegate = self
        emailAddress.delegate = self
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
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

    func showAlert(message: String, error:NSError)
    {
        let alert = UIAlertController(title: message, message: error.localizedDescription, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
}




