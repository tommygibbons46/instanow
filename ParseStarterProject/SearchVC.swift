import UIKit
class SearchVC: UIViewController
{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var showCommentLabel: UILabel!

    var kommentsArray: [Komment] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        println(User.currentUser())
    }


    @IBAction func onCommentItButtonPressed(sender: UIButton)
    {
        let komment = Komment()
        komment.commentBody = self.textField.text

        komment.commenter = User.currentUser() as User

        komment.saveInBackgroundWithBlock
        {
            (success: Bool, error: NSError!) -> Void in
            if (success)
            {
                println("KOMMENT saved comment")
            }
            else
            {
                println("KOMMENT no saved")
            }
        }
    }

    @IBAction func onGetCommentButtonTapped(sender: UIButton)
    {
        let query = Komment.query()
        query.whereKey("commenter", equalTo: User.currentUser())
        query.findObjectsInBackgroundWithBlock
        {
            (returnedObjects, returnedError) -> Void in
            if returnedError == nil
            {
                self.kommentsArray = returnedObjects as [Komment]
                println("retrieved")
            }
            else
            {
                println("there was an error")
            }
        }
    }


    @IBAction func onSaveToUserButtonTapped(sender: UIButton)
    {
        var relation = User.currentUser().relationForKey("komments")
        relation.addObject(self.kommentsArray.last)

        User.currentUser().saveInBackgroundWithBlock
        {
            (success : Bool, error : NSError!) -> Void in
            if (success)
            {
                println("USER saved comment")
            }
            else
            {
                println("USER no saved")
            }
        }
    }

    @IBAction func onShowCommentButtonTapped(sender: UIButton)
    {
        var relation = User.currentUser().relationForKey("komments")
        relation.query().findObjectsInBackgroundWithBlock
        {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error != nil
            {
                println("there was an error")
            }
            else
            {
                var theKomment = objects.last as Komment
                self.showCommentLabel.text = theKomment.commentBody
            }
        }
    }


}
