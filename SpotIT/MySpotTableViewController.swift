//
//  MySpotTableViewController.swift
//  SpotIT
//
//  Created by Florian Briou on 08/02/2015.
//  Copyright (c) 2015 Florian Briou. All rights reserved.
//

import UIKit

class MySpotTableViewController: PFQueryTableViewController {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Set the parse display information
        self.parseClassName = "Spot"
        self.textKey = "name"
        self.imageKey = "image"
        self.title = "Mes Spots"
        self.paginationEnabled = true
        self.objectsPerPage = 7
        
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
    
}
