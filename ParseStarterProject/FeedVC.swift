import UIKit
import Parse
class FeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate



{
    var usersArray: [PFObject] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if PFUser.currentUser() == nil
        {
            performSegueWithIdentifier("LoginSegue", sender: self)
        }
        let query = PFQuery(className: "_User")
        query.whereKey("username", equalTo: "tgibbons@princeton.edu")
        query.findObjectsInBackgroundWithBlock { (returnedObjects, returnedError) -> Void in
            println(self.usersArray = returnedObjects as [PFObject])
        }

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as UITableViewCell
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}


