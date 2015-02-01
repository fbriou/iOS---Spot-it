//
//  SendSpotViewController.swift
//  Spot'It
//
//  Created by Florian Briou on 01/02/2015.
//  Copyright (c) 2015 Florian Briou. All rights reserved.
//

import UIkit

class SendSpotViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Create a recognizer for the imagePicker
        let recognizer = UITapGestureRecognizer(target: self, action: "displayImagePicker:")
        recognizer.numberOfTapsRequired = 1
        
        //Add the recognizer to the image view
        imageView.addGestureRecognizer(recognizer)
        
    }
    
    
    func displayImagePicker(recog : UIGestureRecognizer){
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
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
    
    
    //MARK: Image Picker Controller Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
}