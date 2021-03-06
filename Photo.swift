import Foundation
import Parse

class Photo : PFObject, PFSubclassing
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
        return "Photo"
    }

    @NSManaged var actualImage : PFFile
    @NSManaged var numberOfLikes : NSNumber

    @NSManaged var photographer : User

    @NSManaged var photographerName : String

    @NSManaged var comments : Comment



    
    
    
    
}