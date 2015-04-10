import UIKit
class UserProfileVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    var photosArray: [Photo] = []

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var numberOfFriendsLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.personNameLabel.text = User.currentUser()?.username
        let userImageFile = User.currentUser()!.profilePic
        userImageFile.getDataInBackgroundWithBlock
        {
            (imageData, error) -> Void in
            if error == nil
            {
                var imageToRender = UIImage(data:imageData!)
                self.profileImageView.image = imageToRender
            }
        }
        loadFriendsPhotos()
    }

    override func viewWillAppear(animated: Bool)
    {
        self.collectionView.reloadData()
    }


    func loadFriendsPhotos()
    {
        let photoQuery = Photo.query()
        photoQuery?.whereKey("photographer", equalTo: User.currentUser()!)
        photoQuery!.orderByDescending("createdAt")
        photoQuery!.findObjectsInBackgroundWithBlock
        { (returnedPhotos, returnedError) -> Void in
            if returnedError == nil
            {
                self.photosArray = returnedPhotos as! [Photo]
                self.collectionView.reloadData()
                println("user photos retrieved")
                println(self.photosArray)
            }
            else
            {
                println("there was an error while retrieving photos")
            }
        }
    }



    @IBAction func onFollowButtonPressed(sender: UIButton)
    {

    }

    @IBAction func onCollectionViewPhotosButtonPressed(sender: UIButton)
    {

    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.photosArray.count
    }

//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
//    {
//        return 1
//    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath) as! CustomCollectionViewCell
        var photoToRender = self.photosArray[indexPath.row]
        let userImageFile = photoToRender.actualImage
        userImageFile.getDataInBackgroundWithBlock
        {
            (imageData, error) -> Void in
            if error == nil
            {
                var imageToRender = UIImage(data:imageData!)!
                cell.imageView.image = imageToRender
            }
        }
        return cell
    }



    
}
