//
//  MySpotTableViewController.swift
//  SpotIT
//
//  Created by Florian Briou on 08/02/2015.
//  Copyright (c) 2015 Florian Briou. All rights reserved.
//

import UIKit
import CoreData

class MySpotTableViewController: PFQueryTableViewController {
    
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Set the parse display information
        self.parseClassName = "Spot"
        self.textKey = "name"
        self.imageKey = "image"
        self.title = "Mes Spots"
        self.paginationEnabled = true
        self.objectsPerPage = 7
        
        //self.loginCheck()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.loginCheck()
    }
    func loginCheck(){
        
        
        
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let context:NSManagedObjectContext = appDel.managedObjectContext! as NSManagedObjectContext
        
        //var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        
        //newUser.setValue("Mareva", forKey: "username")
        //newUser.setValue("pass2", forKey: "password")
        
        //context.save(nil)
        
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        
        var results = context.executeFetchRequest(request, error: nil)
        println(results)
        
        if results?.count > 0 {
            
            for result: AnyObject in results! {
                if let loginCheck = result.valueForKey("loginCheck") as? String {
                    println(loginCheck)
                    if loginCheck == "NOK"{
                        performSegueWithIdentifier("jumpToLogin", sender: self)
                    }
                }
                
            }
            
        }else{
            //First launch
            println("First launch")
            var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
            
            newUser.setValue("NOK", forKey: "loginCheck")
            
            context.save(nil)
        }
        
    
        
        
    }
    
    
    override func queryForTable() -> PFQuery! {
        // Create the query
        let query = PFQuery(className: self.parseClassName)
        
        //If nothing get the cache
        if self.objects.count == 0{
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        }
        
        query.orderByDescending("createdAt")
        
        return query
        
        
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath){
            if cell.textLabel?.text != "Load more..."{
                self.performSegueWithIdentifier("showDetail", sender: self)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"{
            var indexPath:NSIndexPath? = nil
            if self.tableView.indexPathForSelectedRow() == nil{
                //It's for the ipad or iphone 6 plus which need to be init
                indexPath = NSIndexPath(forRow: 0, inSection: 0)
            }else{
                indexPath = self.tableView.indexPathForSelectedRow()
            }
            
            let message = self.objects[indexPath!.row] as PFObject
            
            let detailViewController = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
            detailViewController.detailItem = message
            
            detailViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            detailViewController.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    //In order to select a Spot by default on ipad and Iphone 6 (landscape)
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if size.width >= 736 {
            self.performSegueWithIdentifier("showDetail", sender: self)
        }
        
    }
    
}
