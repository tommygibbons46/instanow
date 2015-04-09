import UIKit
class SearchVC: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var showCommentLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var usersArray: [User] = []


    var kommentsArray: [Comment] = []
    var kommentsIndexedToUserArray: [Comment] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadUsers()
        self.textField.delegate = self
        
    }

    func loadUsers()
    {
        let query = User.query()!
        query.findObjectsInBackgroundWithBlock
            { (returnedObjects, returnedError) -> Void in
                if returnedError == nil
                {
                    self.usersArray = returnedObjects as! [User]
                }
                else
                {
                    println("there was an error")
                }
        }
        println(self.usersArray)
    }

    





    


}
