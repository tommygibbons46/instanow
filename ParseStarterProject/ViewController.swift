import UIKit
import Parse
class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()


        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackground()




    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

