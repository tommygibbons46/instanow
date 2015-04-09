import UIKit
import Parse
class FeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    var imageToRender = UIImage()

    @IBOutlet weak var tableView: UITableView!
    var usersArray: [User] = []
    var photosArray: [Photo] = []
    var refreshControl = UIRefreshControl()
    override func viewDidLoad()
    {
        super.viewDidLoad()
      //  self.loadUsers() //// no longer need this function
        self.refreshControl = UIRefreshControl()
        self.refreshControl.backgroundColor = UIColor.greenColor()
        self.refreshControl.tintColor = UIColor.whiteColor()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents:UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    func refresh(sender: AnyObject)
    {
        loadPhotos()
    }

    override func viewDidAppear(animated: Bool)
    {
        if PFUser.currentUser() == nil
        {
            self.performSegueWithIdentifier("LogInSegue", sender: self)
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.loadPhotos() ///check for method that will only look to load if changes have occured
    }

    func loadPhotos()
    {
        let photoQuery = Photo.query()
        photoQuery.orderByDescending("createdAt")
        photoQuery.findObjectsInBackgroundWithBlock { (returnedPhotos, returnedError) -> Void in
            if returnedError == nil
            {
                self.photosArray = returnedPhotos as [Photo]
                self.tableView.reloadData()
                println(self.photosArray)
                self.refreshControl.endRefreshing()
            }
            else
            {
                println("there was an error while retrieving photos")
            }
        }
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

        println(self.usersArray)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as FeedCell
        var photoToRender = self.photosArray[indexPath.row]
//        var userToRender = self.usersArray[indexPath.row]
//        cell.friendsNameLabel.text = userToRender.username
        cell.friendsNameLabel.text = photoToRender.photographerName


//        let userImageFile = userToRender.profilePic
        let userImageFile = photoToRender.actualImage
        userImageFile.getDataInBackgroundWithBlock
        {
            (imageData: NSData!, error: NSError!) -> Void in
            if error == nil
            {
                var imageToRender = UIImage(data:imageData)!
                cell.feedImage.image = imageToRender

            }
        }
        return cell
    }

        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.photosArray.count
    }
}


