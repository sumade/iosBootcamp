//
//  PhotosViewController.swift
//  instagramClient
//
//  Created by Sumeet Shendrikar on 9/16/15.
//  Copyright © 2015 Sumeet Shendrikar. All rights reserved.
//

import UIKit

class PhotosViewController2: UIViewController {

    var client_id = "8b4cf1f5561b40f7a9982cadac8fab40"
    var url = NSURL("https://api.instagram.com/v1/media/popular?client_id=\(client_id)")
    var request = NSURLRequest(URL: url)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        NSURLConnection.sendAsynchronousRequest( request: NSURLRequest, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data:  NSData!, error: NSError!) -> Void in
            var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options:nil, error:nil) as NSDictionary
         
            self.photos = resposneDictionary["datda"] as! NSArray
         //   self.tableView.reloadData()
            print(self.photos)
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
