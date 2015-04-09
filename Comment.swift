import Foundation
class Comment : PFObject, PFSubclassing
{
    override class func initialize()
    {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken)
        {
            self.registerSubclass()
        }
    }

    class func parseClassName() -> String!
    {
        return "Comment"
    }


    @NSManaged var commentBody: String
    @NSManaged var commenter : User
    @NSManaged var photo : Photo





}