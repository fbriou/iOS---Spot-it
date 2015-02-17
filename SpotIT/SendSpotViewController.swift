//
//  SendSpotViewController.swift
//  Spot'It
//
//  Created by Florian Briou on 01/02/2015.
//  Copyright (c) 2015 Florian Briou. All rights reserved.
//

import UIkit
import CoreData

class SendSpotViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Core data test
        println("test")
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObjectContext
        
        newUser.setValue("Florian", forKey: "username")
        newUser.setValue("pass", forKey: "password")
        
        context.save(nil)
        
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        var results = context.executeFetchRequest(request, error: nil)
        println(results)

        
        
        
        //Create a recognizer for the imagePicker
        let recognizer = UITapGestureRecognizer(target: self, action: "displayImagePicker:")
        recognizer.numberOfTapsRequired = 1
        //Add the recognizer to the imageView
        imageView.addGestureRecognizer(recognizer)
    }
    
    
    func displayImagePicker (recog:UITapGestureRecognizer){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        //Get the photo library
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    @IBAction func sendSpot(sender: AnyObject) {
        
        let spot = PFObject(className: "Spot")
        spot["name"] = nameLabel.text
        spot["description"] = descriptionLabel.text
        
        let imageData = UIImageJPEGRepresentation(imageView.image, 0.5)
        let spotImage = PFFile(data: imageData)
        
        spotImage.saveInBackgroundWithBlock({ (success:Bool, error:NSError!) -> Void in
            
            if success {
                spot["image"] = spotImage
                spot.saveInBackgroundWithBlock(nil)
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
            
            }, progressBlock: { (progress:Int32) -> Void in
            
                var progressF:Float = (Float(progress) / 100)
                self.progressBar.setProgress(progressF, animated: true)
        })
        
    }
    
    
    
    @IBAction func dismissVC(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // MARK: Image Picker Controller Delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
    
    
    
}