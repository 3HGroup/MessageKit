//
//  RSVPSystemMessageSizeCalculator.swift
//  MessageKit
//
//  Created by Liyu Wang on 15/10/18.
//  Copyright © 2018 MessageKit. All rights reserved.
//

import Foundation

open class RSVPSystemMessageSizeCalculator: TextMessageSizeCalculator {
    
    open override func messageContainerMaxWidth(for message: MessageType) -> CGFloat {
        let maxWidth = super.messageContainerMaxWidth(for: message)
        
        var iconWidth: CGFloat = 0
        if case .rsvpSystem(let systemItem) = message.kind {
            switch systemItem.style {
            case .favorite:
                iconWidth = RSVP_SystemMsgCellIconSize
            default:
                iconWidth = 0
            }
        }
        return maxWidth - (iconWidth + 2 * RSVP_SystemMsgCellPadding + RSVP_SystemMsgCellPadding)
    }
    
    open override func messageContainerSize(for message: MessageType) -> CGSize {
        let maxWidth = messageContainerMaxWidth(for: message)
        
        var messageContainerSize: CGSize
        let attributedText: NSAttributedString
        
        var titleHeight: CGFloat = 0
        var iconWidth: CGFloat = 0
        
        switch message.kind {
            
        case .rsvpSystem(let systemItem):
            attributedText = NSAttributedString(string: systemItem.text, attributes: [.font: UIFont.systemFont(ofSize: 15)])
            
            switch systemItem.style {
            case .favorite:
                titleHeight = 0
                iconWidth = RSVP_SystemMsgCellIconSize
            case .profileInfo:
                titleHeight = RSVP_SystemMsgCellTitleHeight
                iconWidth = 0
            }
        default:
            fatalError("messageContainerSize received unhandled MessageDataType: \(message.kind)")
        }
        
        messageContainerSize = labelSize(for: attributedText, considering: maxWidth)
        // important: strictly reset the width to maxwidth
        messageContainerSize = CGSize(width: maxWidth, height: messageContainerSize.height)
        
        let messageInsets = messageLabelInsets(for: message)
        messageContainerSize.width += messageInsets.horizontal
        messageContainerSize.height += messageInsets.vertical
        
        messageContainerSize.width += (iconWidth + 2 * RSVP_SystemMsgCellPadding + RSVP_SystemMsgCellPadding)
        messageContainerSize.height += (titleHeight + RSVP_SystemMsgCellPadding + RSVP_SystemMsgCellPadding)
        
        return messageContainerSize
    }
}
