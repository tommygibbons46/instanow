import Foundation
class User : PFUser, PFSubclassing
{

    override class func initialize()
    {
        registerSubclass()
    }

//    override class func initialize()
//    {
//        // RICH SAYS THE 2 LINES UNDEARNEATH ARE SO IT DOENST RUN ON THE MAIN THREAD, HE SAYS HE NEVER USES THIS FOR PFUSER THOUGH, SO COMMENT IT OUT FOR PFUSER
//        var onceToken : dispatch_once_t = 0; // mychilo thinks, this is an old school boolean that keeps track if it has run yet, right now it hasnt since it's 0
//        dispatch_once(&onceToken) // mychilo thinks this is just grand central dispatch stuff
//        {
////                self.registerSubclass()
//        }
//    }

//    @NSManaged var comments: Comment
//    @NSManaged var photos: Photo

    @NSManaged var friends: User


    
    @NSManaged var profilePic: PFFile
    

    // DONT INCLUDE THIS WHEN SUBCLASSING PFUSER
//    override class func parseClassName() -> String! // i had to change "class" from "static" according to xcode
//    {
//        return "User"
//    }


    
    
    
    
}