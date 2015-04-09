import Foundation
class User : PFUser, PFSubclassing
{

    override class func load()
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

    
    @NSManaged var firstName: String
    @NSManaged var lastName: String

    @NSManaged var komments: Komment

    // xcode says i cant overwrite this ones since they come by default in pfuser i think
//    @NSManaged var email: String
//    @NSManaged var username: String
//    @NSManaged var password: String


    // DONT INCLUDE THIS WHEN SUBCLASSING PFUSER
//    override class func parseClassName() -> String! // i had to change "class" from "static" according to xcode
//    {
//        return "User"
//    }


    
    
    
    
}