import UIKit
class LogInViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        password.secureTextEntry = true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return false
    }

    @IBAction func signUp(sender: UIButton)
    {
        let user = User()
        user.username = usernameTextField.text
        user.password = password.text
        user.email = emailAddress.text
        user.signUpInBackgroundWithBlock { (returnedResult, returnedError) -> Void in
            if returnedError == nil
            {
                self.dismissViewControllerAnimated(true, completion: nil)
                println("SIGNED UP SUCCESS")

                ////////////////////////////////////////////////////////////////

                var relation = User.currentUser()?.relationForKey("friends")
                relation?.addObject(User.currentUser()!)

                User.currentUser()!.saveInBackgroundWithBlock
                    { (success, error) -> Void in
                        if success
                        {
                            println("relation saved")
                            println(User.currentUser()?.friends)

                            relation?.query()?.findObjectsInBackgroundWithBlock
                            { (allRelations, error) -> Void in
                                if error == nil
                                {
                                    println("ALL RELATIONS BELOW")
                                    println(allRelations)
                                }
                                else
                                {
                                    println("relations NOT found")
                                }
                            }
                        }
                        else
                        {
                            println("relation NOT saved")
                        }
                }

                ////////////////////////////////////////////////////////////////


            }
            else
            {
                self.showAlert("There was an error with your sign up", error: returnedError!)
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
                self.showAlert("There was an error with your login", error: returnedError!)
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




