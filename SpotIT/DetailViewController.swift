//
//  DetailViewController.swift
//  Spot'It
//
//  Created by Florian Briou on 26/01/2015.
//  Copyright (c) 2015 Florian Briou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var spotImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!

    var detailItem: PFObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: PFObject = self.detailItem {
            
            if let textView = descriptionTextView {
                textView.text = detail["description"] as? String
            }
            
            let imageFile = detail["image"] as? PFFile
            imageFile?.getDataInBackgroundWithBlock({ (data:NSData!, error: NSError!) -> Void in
                if error == nil{
                    let image = UIImage(data: data)
                    self.spotImageView.image = image
                }
                
                }, progressBlock: { (progress:Int32) -> Void in
                //println(progress)
                    
            })
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

