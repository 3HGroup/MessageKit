//
//  ReplyItem.swift
//  MessageKit
//
//  Created by Khristoffer Julio  on 7/15/21.
//

import UIKit
 
public protocol ReplyItem {
    var iconUrl: String? { get }
    
    var name: NSAttributedString { get }
    
    var message: String { get }
    
    var quoteMessage: String { get }
}
