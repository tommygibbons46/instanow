import Foundation
class Komment : PFObject, PFSubclassing
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
        return "Komment"
    }


    @NSManaged var commentBody: String
    @NSManaged var commenter : User


    // XCODE SAYS CHANGE STATIC TO CLASS
//    static func parseClassName() -> String! {
//        return "Armor"
//    }




}