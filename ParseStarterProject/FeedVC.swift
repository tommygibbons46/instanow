import UIKit
import Parse
class FeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var photosArray: [Photo] = []
    var likesArray: [Like] = []
    var friendsArray: [User] = []
    var refreshControl = UIRefreshControl()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl.backgroundColor = UIColor.grayColor()
        self.refreshControl.tintColor = UIColor.whiteColor()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents:UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.loadFriendsPhotos()
    }
    func refresh(sender: AnyObject)
    {
        loadFriendsPhotos()
    }

    override func viewDidAppear(animated: Bool)
    {
        if PFUser.currentUser() == nil
        {
            self.performSegueWithIdentifier("LogInSegue", sender: self)
        }
    }

    override func viewWillAppear(animated: Bool)
    {
        self.loadFriendsPhotos()
    }


//    func loadPhotos()
//    {
//        let photoQuery = Photo.query()
//        photoQuery!.orderByDescending("createdAt")
//        photoQuery!.findObjectsInBackgroundWithBlock { (returnedPhotos, returnedError) -> Void in
//            if returnedError == nil
//            {
//                self.photosArray = returnedPhotos as! [Photo]
//                self.tableView.reloadData()
//               // println(self.photosArray)
//                self.refreshControl.endRefreshing()
//            }
//            else
//            {
//                println("there was an error while retrieving photos")
//            }
//        }
//    }


    func loadFriendsPhotos()
    {
        var currentUser = User.currentUser()
        var relation = currentUser?.relationForKey("friends")
        relation?.query()?.findObjectsInBackgroundWithBlock
        { (allRelations, error) -> Void in
        if error == nil
            {
                self.friendsArray = allRelations as! [User]

                ///////////////////////////////////////////////////////////////////////

                let photoQuery = Photo.query()
                photoQuery?.whereKey("photographer", containedIn: self.friendsArray)
                photoQuery!.orderByDescending("createdAt")
                photoQuery!.findObjectsInBackgroundWithBlock
                    { (returnedPhotos, returnedError) -> Void in
                        if returnedError == nil
                        {
                            self.photosArray = returnedPhotos as! [Photo]
                            self.tableView.reloadData()
                            self.refreshControl.endRefreshing()
                        }
                        else
                        {
                            println("there was an error while retrieving photos")
                        }
                }

                ///////////////////////////////////////////////////////////////////////


            }
        else
            {
                println("relations NOT found")
            }
        }
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as! FeedCell
        var photoToRender = self.photosArray[indexPath.row]
        cell.friendsNameLabel.text = photoToRender.photographerName
        let userImageFile = photoToRender.actualImage
        userImageFile.getDataInBackgroundWithBlock
        {
            (imageData, error) -> Void in
            if error == nil
            {
                var imageToRender = UIImage(data:imageData!)!
                cell.feedImage.image = imageToRender

            }
        }
        let numberOfLikes = photoToRender.numberOfLikes
        let likesNumber = numberOfLikes.integerValue
        let numberOfLikesString = String(likesNumber)
        cell.numberOfLikesLabel.text = numberOfLikesString
        cell.likeButton.tag = indexPath.row
        cell.commentButton.tag = indexPath.row
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.photosArray.count
    }


    @IBAction func onLikeButtonTapped(sender: UIButton)
    {
        let selectedCellIndex = sender.tag
        let indexPath = NSIndexPath(forRow: selectedCellIndex, inSection: 0)
        let photoToLike = self.photosArray[selectedCellIndex]
        let numberOfLikes = photoToLike.numberOfLikes
        let likesNumber = numberOfLikes.integerValue + 1
        photoToLike.numberOfLikes = likesNumber
        photoToLike.saveInBackgroundWithBlock
        {
            (success, error) -> Void in
            if (success)
            {
                println("saved photo")
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
            }
            else
            {
                println("photo not saved")
            }
        }

        let like = Like(className: "Like")
        like.liker = User.currentUser()!
        like.photo = photoToLike
        like.saveInBackgroundWithBlock
        {
            (success, error) -> Void in
            if (success)
            {
                println("SAVED like")
            }
            else
            {
                println("LIKE not saved")
            }
        }
    }


    @IBAction func onCommentButtonTapped(sender: UIButton)
    {
        performSegueWithIdentifier("toPhotoComments", sender: sender)
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "toPhotoComments"
        {
            let buttonSender = sender as! UIButton
            let selectedCellIndex = sender?.tag
            let photoCommentsVC = segue.destinationViewController as! PhotoCommentsVC
            photoCommentsVC.selectedPhoto = self.photosArray[selectedCellIndex!]
        }
    }




}


