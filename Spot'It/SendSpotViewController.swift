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
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Create a recognizer for the imagePicker
        let recognizer = UITapGestureRecognizer(target: self, action: "displayImagePicker:")
        recognizer.numberOfTapsRequired = 1
        
        //Add the recognizer to the  image view
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