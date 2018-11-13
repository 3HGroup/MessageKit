//
//  RSVPProfileSummarySizeCalculator.swift
//  MessageKit
//
//  Created by Liyu Wang on 12/11/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import Foundation

open class RSVPProfileSummarySizeCalculator: TextMessageSizeCalculator {
    open override func messageContainerMaxWidth(for message: MessageType) -> CGFloat {
        // TODO: check the RSVPSystemMessageSizeCalculator implementation
        return 10
    }
    
    open override func messageContainerSize(for message: MessageType) -> CGSize {
        // TODO: check the RSVPSystemMessageSizeCalculator implementation
        return CGSize(width: 10, height: 10)
    }
}
