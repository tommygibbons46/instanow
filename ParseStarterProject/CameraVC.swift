import UIKit
class CameraVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        showAlertOnViewController()
    }

    func showAlertOnViewController()
    {
        let alert = UIAlertController(title: nil, message: "Camera", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .Default, handler: { (action1) -> Void in
            self.showTakePhotoView()
        }))
        alert.addAction(UIAlertAction(title: "Choose From Library", style: .Default, handler: { (action2) -> Void in
            self.showChooseFromLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action3) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))

        self.presentViewController(alert, animated: true, completion: nil)
    }



    func showTakePhotoView()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }

    func showChooseFromLibrary()
    {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        {
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(imagePicker: UIImagePickerController)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        dismissViewControllerAnimated(true, completion: nil)


        var theImage = Photo(className: "Photo")


        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImagePNGRepresentation(image)

//        let imageFile = PFFile(name:"imageName", data:imageData)

        theImage.actualImage = PFFile(name: "ourImage", data: imageData)
        theImage.photographer = User.currentUser()!
        theImage.photographerName = User.currentUser()!.username!

        User.currentUser()!.profilePic = theImage.actualImage

        theImage.saveInBackgroundWithBlock
            {
                (success, error) -> Void in
                if (success)
                {
                    println("saved img")
//                    self.onGetCommentButtonTapped()
                }
                else
                {
                    println("no saved")
                }
        }
    }
    



    
    
}
