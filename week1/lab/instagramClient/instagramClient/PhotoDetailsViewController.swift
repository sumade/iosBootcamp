//
//  PhotoDetailsViewController.swift
//  instagramClient
//
//  Created by Sumeet Shendrikar on 9/16/15.
//  Copyright © 2015 Sumeet Shendrikar. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // stores the image url as a string
    var imageURL: String?
    
    // stores the comments as an array of dictionaries
    var comments: [NSDictionary]?
  
    // the table view for the photo details page
    @IBOutlet weak var photoDetailsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        photoDetailsTable.delegate = self
        photoDetailsTable.dataSource = self
        photoDetailsTable.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // the number of rows = image row + 1 row for each comment
        if let commentCount = comments?.count {
            return 1 + commentCount
        }

        // no comments... so just return the image row
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // we need to provide the image row, which uses the PhotoDetailsViewImageCell type
            let cell = photoDetailsTable.dequeueReusableCellWithIdentifier("photoDetailsImageCell", forIndexPath: indexPath) as! PhotoDetailsViewImageCell
            cell.photoDetailsImageViewCell.setImageWithURL(NSURL(string: imageURL!)!)
            return cell
        }else{
            // a comment row, which uses the PhotoDetailsViewCommentCell type
            let cell = photoDetailsTable.dequeueReusableCellWithIdentifier("photoDetailsCommentCell", forIndexPath: indexPath) as! PhotoDetailsViewCommentCell
            
            // lookup the comments array for the comment dictionary corresponding to the row, and then look for the "text" key
            if let text = comments?[indexPath.row-1]["text"] {
                // set the comment label
                cell.photoDetailsCommentLabel.text = text as! String
            }
            
            return cell
        }
    }
    

    // estimate the row height based on content (not sure why this works... )
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            // image row
            return 320
        }else{
            // comment row
            return 60
        }
    }

    // calculate the row height based on content (may have a performance implication... )
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            // image row
            return 320
        }else{
            // comment row
            return 60
        }
    }

}
