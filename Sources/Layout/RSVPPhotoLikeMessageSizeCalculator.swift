//
//  RSVPPhotoLikeMessageSizeCalculator.swift
//  MessageKit
//
//  Created by Liyu Wang on 15/8/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import Foundation

open class RSVPPhotoLikeMessageSizeCalculator: TextMessageSizeCalculator {
    open override func messageContainerSize(for message: MessageType) -> CGSize {
        let maxWidth = messageContainerMaxWidth(for: message)
//        return CGSize(width: maxWidth * 4 / 5, height: RSVP_likedPhotoSize.height + 2 * RSVP_photoLikeCellPadding)
        
        var messageContainerSize: CGSize
        let attributedText: NSAttributedString
        
        switch message.kind {

        case .photoLike(_, let text):
            attributedText = NSAttributedString(string: text, attributes: [.font: messageLabelFont])
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }
        messageContainerSize = labelSize(for: attributedText, considering: maxWidth)
        let messageInsets = messageLabelInsets(for: message)
        messageContainerSize.width += messageInsets.horizontal
        
        messageContainerSize.width += RSVP_likedPhotoSize.height + 2 * RSVP_photoLikeCellPadding
        messageContainerSize.height = RSVP_likedPhotoSize.height + 2 * RSVP_photoLikeCellPadding
        
        return messageContainerSize
    }
}
