import UIKit
import Parse
class FeedVC: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackground()
    }
}


