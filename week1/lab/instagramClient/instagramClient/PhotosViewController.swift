//
//  ViewController.swift
//  instagramClient
//
//  Created by Sumeet Shendrikar on 9/16/15.
//  Copyright © 2015 Sumeet Shendrikar. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // photo table for main view
    @IBOutlet weak var photoTableView: UITableView!
    
    // sumeet's client id
    let client_id_me: String = "8b4cf1f5561b40f7a9982cadac8fab40"

    // used to store the results from the instagram call
    var media : [NSDictionary] = []
    
    // pull to refresh
    var refreshControl:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // setup table view
        photoTableView.dataSource = self
        photoTableView.delegate = self
        photoTableView.rowHeight = 320
        
        // setup refresh control
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.photoTableView.addSubview(refreshControl)
        
        // hack to allow refresh without a table view controller (http://guides.codepath.com/ios/Table-View-Guide#without-a-uitableviewcontroller)
        let dummyTableVC = UITableViewController()
        dummyTableVC.tableView = self.photoTableView
        dummyTableVC.refreshControl = self.refreshControl
        
        // get the data from instagram
        loadData()
    }
    
    func loadData() {
        let url = NSURL(string: "https://api.instagram.com/v1/media/popular?client_id=\(client_id_me)")
        let request = NSURLRequest(URL: url!)
        
        // Do any additional setup after loading the view
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response, dataOrNil, errorOrNil) -> Void in
            if let data = dataOrNil {
                let object = try! NSJSONSerialization.JSONObjectWithData(data, options:[])
                
                // this was the original way we had it implemented, when just storing the url strings
                /*
                if let results = object["data"] as? NSArray {
                for result in results as! [NSDictionary] {
                if let imageDictionary = result["images"] as? NSDictionary {
                if let thumbNailDictionary = imageDictionary["thumbnail"] as? NSDictionary {
                if let imageURL = thumbNailDictionary["url"] as? String {
                self.photos.append(imageURL)
                }
                }
                }
                
                }
                self.photoTableView.reloadData()
                //print(self.photos.count)
                }
                */
                
                // new way...
                // store the raw JSON array
                if let results = object["data"] as? NSArray {
                    self.media = results as! [NSDictionary]
                    
                    self.photoTableView.reloadData()
                    
                    // hack for refresh controller
                    self.refreshControl.endRefreshing()
                }
            }else{
                if let error = errorOrNil {
                    NSLog("Error: \(error)")
                }
            }
        }
    }
    
    func refresh(sender:AnyObject)
    {
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.media.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = photoTableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PhotoTableViewCell
        if self.media == [] {
            //nothing to display
        }
        else {
            // this was our original method
            //   cell.photoImageViewCell.setImageWithURL(NSURL(string: self.photos[indexPath.row])!)
            
            // the new way...
            // parse the JSON array for the thumbnail image url
            if let imageDictionary = self.media[indexPath.row]["images"] as? NSDictionary {
                if let thumbNailDictionary = imageDictionary["thumbnail"] as? NSDictionary {
                    if let imageURL = thumbNailDictionary["url"] as? String {
                        cell.photoImageViewCell.setImageWithURL(NSURL(string: imageURL)!)
                    }
                }
            }
        }
        return cell
    }
        
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        photoTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // user selected a row
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! PhotoDetailsViewController
        let indexPath = photoTableView.indexPathForCell(sender as! UITableViewCell)!
        
        // parse the JSON array for the low_resolution image url
        if let imageDictionary = self.media[indexPath.row]["images"] as? NSDictionary {
            if let thumbNailDictionary = imageDictionary["low_resolution"] as? NSDictionary {
                if let imageURL = thumbNailDictionary["url"] as? String {
                    vc.imageURL = imageURL
                }
            }
        }
        
        // parse the JSON array for the comments dictionary array
        if let commentsDict = self.media[indexPath.row]["comments"] as? NSDictionary {
            if let comments = commentsDict["data"] as? NSArray {
                vc.comments = comments as? [NSDictionary]
            }
        }
        
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

