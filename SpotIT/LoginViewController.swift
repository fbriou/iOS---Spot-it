//
//  LoginViewController.swift
//  SpotIT
//
//  Created by Florian Briou on 16/02/2015.
//  Copyright (c) 2015 Florian Briou. All rights reserved.
//


import UIkit
import CoreData

class LoginViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func loginButton(sender: AnyObject) {
        
    //Update loginCheck data in order to avoid login screen in the futur
        
        //Init CoreDate
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext! as NSManagedObjectContext
        
        //Init Request
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        //Get Results
        var results = context.executeFetchRequest(request, error: nil)
        
        if results?.count > 0 {
            
            for result: AnyObject in results! {
                if let loginCheck = result.valueForKey("loginCheck") as? String {
                    if loginCheck == "NOK"{
                        //Set loginCheck to OK
                        result.setValue("OK", forKey: "loginCheck")
                        context.save(nil)
                    }
                }
            }
        }
        
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    
}
