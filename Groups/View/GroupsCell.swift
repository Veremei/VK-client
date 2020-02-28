//
//  GroupsCell.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/14/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import UIKit
import Kingfisher

class GroupsCell: UITableViewCell {

    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        groupImageView?.layer.cornerRadius = (groupImageView?.bounds.height ?? 20) / 2
        groupImageView?.clipsToBounds = true
    }

    
 

}
