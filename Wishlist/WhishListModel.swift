//
//  WhishListModel.swift
//  Wishlist
//
//  Created by user on 1/8/25.
//

import Foundation
import SwiftData

@Model
class Wish{
    var title : String
    
    
    init(title: String) {
        self.title = title
    }
}
