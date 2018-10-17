//
//  RSVPSystemItem.swift
//  MessageKit
//
//  Created by Liyu Wang on 15/10/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import Foundation

public enum RSVPSystemMsgStyle: String {
    case favorite = "favorite"
    case profileInfo = "profileInfo"
}

/// A protocol used to represent the data for a rsvp system message.
public protocol RSVPSystemItem {
    var style: RSVPSystemMsgStyle { get }
    
    var title: String? { get }
    
    var icon: UIImage? { get }
    
    var text: String { get }
}
