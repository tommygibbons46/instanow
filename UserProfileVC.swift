import UIKit
class UserProfileVC: UIViewController
{
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.profileImageView.image = UIImage(named: "mertrix")
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
