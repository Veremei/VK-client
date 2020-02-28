//
//  FeedCellModel.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/14/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation


class FeedItemModel {
    var text: String?
    var date: String?
    
    init(element: FeedItem) {

        self.date = "\(Double(element.date ?? 0).getDateStringFromUTC())"
        
        var postText : String = element.text ?? ""
        postText.append("\n")
        element.attachments?.forEach({ (attachment) in
            postText.append(attachment.photo?.text ?? "")
        })
        element.copyHistory?.forEach({ (copy) in
            postText.append(copy.text ?? "")
        })
        self.text = postText
    }
    
    init(date: String?, text: String?) {
        self.date = date
        self.text = text
    }
  
}
