//
//  RSVPProfileSummaryItem.swift
//  MessageKit
//
//  Created by Liyu Wang on 12/11/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import Foundation

/// A protocol used to represent the data for a rsvp profile summary item.
public protocol RSVPProfileSummaryItem {
    var title: String { get }
    
    var text: String? { get }
}
