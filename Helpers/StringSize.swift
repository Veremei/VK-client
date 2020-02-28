//
//  StringSize.swift
//  Training Task
//
//  Created by Veremey, Daniil on 2/17/20.
//  Copyright © 2020 Veremey, Daniil. All rights reserved.
//

import Foundation
import UIKit

class StringSize {
    
    static func getHeight(from object: FeedItemModel) -> CGFloat {
        let postText : String = object.text ?? ""
       
        var itemSize = postText.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30)])
        
        itemSize.height += 30 // date label
        if itemSize.height < 86 { // 100 - cell size
            itemSize.height = 86
        }
        
        return itemSize.height
    }
    
}
