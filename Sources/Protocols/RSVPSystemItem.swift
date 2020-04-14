//
//  RSVPSystemItem.swift
//  MessageKit
//
//  Created by Liyu Wang on 15/10/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import Foundation

public enum RSVPSystemMsgStyle: String {
    case sysDefault = "default"
    case favorite = "favorite"
    case tag = "tag"
    case encrypted = "encrypted"
    case historyDeleted = "historyDeleted"
    case favoritePhoto = "favorite-photo"
    case contacts = "contacts"
    case expired = "expired"
    case rejected = "rejected"
}

/// A protocol used to represent the data for a rsvp system message.
public protocol RSVPSystemItem {
    var style: RSVPSystemMsgStyle { get }
    
    var icon: UIImage? { get }
    
    var attributedText: NSAttributedString { get }
    
    var favoritePhotoId: String? { get }
}
