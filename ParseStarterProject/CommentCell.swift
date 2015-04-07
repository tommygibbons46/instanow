import UIKit
class CommentCell: UITableViewCell
{
    @IBOutlet weak var commenterNameLabel: UILabel!
    @IBOutlet weak var commentBodyLabel: UILabel!

    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
