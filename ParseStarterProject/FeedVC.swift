import UIKit
import Parse
class FeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var usersArray: [User] = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadUsers()
    }

    func loadUsers()
    {
        let query = User.query()
        query.findObjectsInBackgroundWithBlock
        { (returnedObjects, returnedError) -> Void in
            if returnedError == nil
            {
                self.usersArray = returnedObjects as [User]
                self.tableView.reloadData()
            }
            else
            {
                println("there was an error")
            }
        }
    }

    override func viewDidAppear(animated: Bool)
    {
        if PFUser.currentUser() == nil
        {
            self.performSegueWithIdentifier("LogInSegue", sender: self)
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as FeedCell
        var userToRender = self.usersArray[indexPath.row]
        cell.friendsNameLabel.text = userToRender.username
        cell.feedImage.image = UIImage(named: "mertrix")
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.usersArray.count
    }
}


