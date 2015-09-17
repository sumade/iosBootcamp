//
//  PhotoDetailsViewCellTableViewCell.swift
//  instagramClient
//
//  Created by Sumeet Shendrikar on 9/16/15.
//  Copyright © 2015 Sumeet Shendrikar. All rights reserved.
//

import UIKit

/* class for the image cell of the detail view */

class PhotoDetailsViewImageCell: UITableViewCell {

    // the image view object
    @IBOutlet weak var photoDetailsImageViewCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
