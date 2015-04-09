import UIKit
class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var showCommentLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var kommentsArray: [Comment] = []
    var kommentsIndexedToUserArray: [Comment] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }


    @IBAction func onCommentItButtonPressed(sender: UIButton)
    {
        let komment = Comment()
        komment.commentBody = self.textField.text

        komment.commenter = User.currentUser()

        komment.saveInBackgroundWithBlock
        {
            (success: Bool, error: NSError!) -> Void in
            if (success)
            {
                println("KOMMENT saved comment")
                self.onGetCommentButtonTapped()
            }
            else
            {
                println("KOMMENT no saved")
            }
        }
    }

    func onGetCommentButtonTapped()
    {
        let query = Comment.query()
        query.whereKey("commenter", equalTo: User.currentUser())
        query.findObjectsInBackgroundWithBlock
        {
            (returnedObjects, returnedError) -> Void in
            if returnedError == nil
            {
                self.kommentsArray = returnedObjects as [Comment]
                println(self.kommentsArray)
                println("retrieved")
                self.onSaveToUserButtonTapped()
            }
            else
            {
                println("there was an error")
            }
        }
    }


    func onSaveToUserButtonTapped()
    {
//        var cUser = User.currentUser()
//        var komments = cUser.komments
//        // WHY I CANT PRINT THIS? THE ENTIRE THING STOPS
//        println(komments)

        var relation = User.currentUser().relationForKey("komments")
        relation.addObject(self.kommentsArray.last)

        User.currentUser().saveInBackgroundWithBlock
        {
            (success : Bool, error : NSError!) -> Void in
            if (success)
            {
                println("USER saved comment")
                self.onShowCommentButtonTapped()
            }
            else
            {
                println("USER no saved")
            }
        }
    }

    func onShowCommentButtonTapped()
    {
//        // HOW COME THIS ONLY PRINTS ONE??
//        println("cracker")
//        println(User.currentUser().komments)
//        println("cheese")

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
//                // HOW COME THIS ONLY PRINTS ONE TOO??
//                println(User.currentUser().komments)
                self.kommentsIndexedToUserArray = objects as [Comment]
                var theKomment = objects.last as Comment
                self.showCommentLabel.text = theKomment.commentBody

                self.tableView.reloadData()
            }
        }
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as UITableViewCell
        var kommentToRender = self.kommentsIndexedToUserArray[indexPath.row]
        cell.textLabel?.text = kommentToRender.commentBody
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.kommentsIndexedToUserArray.count
    }


    


}
