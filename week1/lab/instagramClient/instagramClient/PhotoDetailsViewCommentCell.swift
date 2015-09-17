//
//  PhotoDetailsViewCommentCell.swift
//  instagramClient
//
//  Created by Sumeet Shendrikar on 9/16/15.
//  Copyright © 2015 Sumeet Shendrikar. All rights reserved.
//

import UIKit

/* class for the comment cell of the detail view */

class PhotoDetailsViewCommentCell: UITableViewCell {

    // the text label for storing the comment text
    @IBOutlet weak var photoDetailsCommentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
