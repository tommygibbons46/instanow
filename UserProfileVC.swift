import UIKit
class UserProfileVC: UIViewController
{
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()

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
    }

    @IBAction func onFollowButtonPressed(sender: UIButton)
    {

    }

    @IBAction func onCollectionViewPhotosButtonPressed(sender: UIButton)
    {

    }

    @IBAction func onPhotosInListButtonPressed(sender: UIButton)
    {

    }

    
}
