import UIKit
class FeedCell: UITableViewCell
{
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var friendsNameLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!

    override func awakeFromNib()
    {
        super.awakeFromNib()

        // this will keep the tableview from recycling images according to rich
        self.feedImage.image = nil
    }




    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }





}
