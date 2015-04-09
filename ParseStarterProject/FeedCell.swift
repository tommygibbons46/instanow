import UIKit
class FeedCell: UITableViewCell
{

    // if you name feedImage as imageView it will crash

    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var friendsNameLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!


    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // change so it logs

    // more stuff here


    @IBAction func onLikeButtonPressed(sender: UIButton)
    {

    }

    @IBAction func onCommentButtonPressed(sender: UIButton)
    {

    }


}
