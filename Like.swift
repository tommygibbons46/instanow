import Foundation
import Parse

class Like : PFObject, PFSubclassing
{
    override class func initialize()
    {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken)
        {
            self.registerSubclass()
        }
    }

    class func parseClassName() -> String
    {
        return "Like"
    }


    @NSManaged var liker : User
    @NSManaged var photo : Photo


}