import UIKit

class PhotoCommentsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!

    var selectedPhoto : Photo?

    var photoComments: [Comment] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool)
    {
        self.queryObjects()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func onCommentButtonTapped(sender: UIButton)
    {
        let comment = Comment(className: "Comment")
        comment.commentBody = self.textField.text
        comment.commenter = User.currentUser()!
        comment.photo = self.selectedPhoto!
        comment.saveInBackgroundWithBlock
        {
            (success, error) -> Void in
            if (success)
            {
                println("saved comment")
                self.queryObjects()
            }
            else
            {
                println("no saved")
            }
        }
    }

    func queryObjects()
    {
        let query = Comment.query()
        query!.whereKey("photo", equalTo: self.selectedPhoto!)
        query!.findObjectsInBackgroundWithBlock
            {
                (returnedObjects, returnedError) -> Void in
                if returnedError == nil
                {
                    self.photoComments = returnedObjects as! [Comment]
//                    println(self.photoComments)
                    println("retrieved")
                    self.tableView.reloadData()
                }
                else
                {
                    println("there was an error")
                }
        }
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as! CommentCell
        let photoCommentToRender = self.photoComments[indexPath.row]
        let theCommenter = photoCommentToRender.commenter as User

        theCommenter.fetchIfNeededInBackgroundWithBlock
        {
            (returnedCommenter, error) -> Void in
            if (error == nil)
            {
                let foundCommenter = returnedCommenter as! User
                cell.commenterNameLabel.text = foundCommenter.username
            }
            else
            {
                println("user not found")
            }
        }
        cell.commentBodyLabel.text = photoCommentToRender.commentBody
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.photoComments.count
    }






}
