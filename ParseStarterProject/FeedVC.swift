import UIKit
import Parse
class FeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var usersArray: [PFUser] = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        if PFUser.currentUser() == nil
//        {
//            performSegueWithIdentifier("LogInSegue", sender: self)
//        }

        let query = PFQuery(className: "_User")
//        query.whereKey("username", equalTo: "hotshot190@aol.com")
        query.findObjectsInBackgroundWithBlock
        { (returnedObjects, returnedError) -> Void in
            if returnedError == nil
            {
                self.usersArray = returnedObjects as [PFUser]
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as FeedCell
        var userToRender = self.usersArray[indexPath.row]
        cell.friendsNameLabel.text = userToRender.username
        cell.imageView?.image = UIImage(named: "mert")
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.usersArray.count
    }
}


