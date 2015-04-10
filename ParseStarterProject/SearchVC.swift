import UIKit
class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UISearchBarDelegate
{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!


    var usersArray: [User] = []
    var isSearching : Bool = false
    var filteredUsers:[User] = []


    var kommentsArray: [Comment] = []
    var kommentsIndexedToUserArray: [Comment] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.searchBar.delegate = self
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        isSearching = true
        loadUsers()
    }

    func searchBarTextDidEndEditing(searchBar: UISearchBar)
    {
        isSearching = false
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        isSearching = false
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        isSearching = false
        self.searchBar.resignFirstResponder()
        loadUsers()
    }


    func filterContentForSearchText(searchText: String)
    {
        self.filteredUsers = self.usersArray.filter({ (user: User) -> Bool in
            let stringMatch = user.username?.rangeOfString(searchText)
            return (stringMatch != nil)
        })

    }

    func loadUsers()
    {
        let query = User.query()!
        if self.searchBar.text != ""
        {
            query.whereKey("username", containsString: self.searchBar.text )
            query.findObjectsInBackgroundWithBlock
                { (returnedObjects, returnedError) -> Void in
                    if returnedError == nil
                    {
                        self.usersArray = returnedObjects as! [User]
                        self.tableView.reloadData()
                        println(self.usersArray)
                    }
                    else
                    {
                        println("there was an error")
                    }
            }
        }
        else
        {
            query.findObjectsInBackgroundWithBlock
                { (returnedObjects, returnedError) -> Void in
                    if returnedError == nil
                    {
                        self.usersArray = returnedObjects as! [User]
                        self.tableView.reloadData()
                        println(self.usersArray)
                    }
                    else
                    {
                        println("there was an error")
                    }
            }
        }
    }




    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as! UITableViewCell
        if self.isSearching
            {
                var userToRender = self.filteredUsers[indexPath.row]
                cell.textLabel?.text = userToRender.username
            }
        else
            {
                var userToRender = self.usersArray[indexPath.row]
                cell.textLabel?.text = userToRender.username
            }
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.isSearching
        {
            return filteredUsers.count
        }
        return self.usersArray.count
    }


}
