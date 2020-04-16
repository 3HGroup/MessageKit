//
//  RSVPPhotoLikeMessageSizeCalculator.swift
//  MessageKit
//
//  Created by Liyu Wang on 15/8/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import Foundation

open class RSVPPhotoLikeMessageSizeCalculator: TextMessageSizeCalculator {
    
    open override func messageContainerMaxWidth(for message: MessageType) -> CGFloat {
        let maxWidth = super.messageContainerMaxWidth(for: message)
        return maxWidth - (RSVP_likedPhotoSize.width + RSVP_heartSize.width + (4 * RSVP_photoLikeCellPadding))
    }
    
    open override func messageContainerSize(for message: MessageType) -> CGSize {
        let maxWidth = messageContainerMaxWidth(for: message)
        
        var messageContainerSize: CGSize
        let attributedText: NSAttributedString
        
        switch message.kind {

        case .photoLike(_, let text):
            attributedText = NSAttributedString(string: text, attributes: [.font: UIFont(name: "AvenirNext-Regular", size: 18)!])
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }
        messageContainerSize = labelSize(for: attributedText, considering: maxWidth)
        let messageInsets = messageLabelInsets(for: message)
        messageContainerSize.width += messageInsets.horizontal
        
        messageContainerSize.width += (RSVP_likedPhotoSize.width + 3 * RSVP_photoLikeCellPadding) 
        let imageHeight = RSVP_likedPhotoSize.height + 2 * RSVP_photoLikeCellPadding
        messageContainerSize.height += 2 * RSVP_photoLikeCellPadding
        
        if messageContainerSize.height < imageHeight {
            messageContainerSize.height = imageHeight
        }
        
        return messageContainerSize
    }
}
